// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ChatProvider extends ChangeNotifier {
  List<Chat> chats = [];
  List<ChatItem> items = [];
  List<User> users = [];
  List<Chat> filteredChats = [];

  late StreamSubscription chatsSub;
  late StreamSubscription mesSub;

  Load state = Load.loading;

  String filter = "";

  setFitler(String filter) {
    if (filter.isEmpty || filter == "") {
      filteredChats = chats.toList();
    } else {
      filteredChats = chats
          .where((element) => getUser(element.user).name == filter)
          .toList();
    }
    notifyListeners();
  }

  ChatProvider(BuildContext context) {
    loadData();
    mesSub = GetIt.I
        .get<Supabase>()
        .client
        .from('ChatItem')
        .stream(primaryKey: ['id']).listen((event) {
      newChatItem(event);
    });

    InternetConnection().onStatusChange.listen((event) {
      if (event == InternetStatus.connected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Есть инет")));
      }
      if (event == InternetStatus.disconnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("нет инета")));
      }
    });
  }

  newChatItem(List<Map<String, dynamic>> val) {
    GetIt.I.get<Talker>().critical(val);
    for (var element in val) {
      items.add(ChatItem.fromMap(element));
    }
    notifyListeners();
  }

  List<ChatItem> getChatMessages(int chatID) {
    List<ChatItem> temp =
        items.where((element) => element.chat_id == chatID).toList();
    temp.sort((a, b) =>
        b.write_time.millisecondsSinceEpoch -
        a.write_time.millisecondsSinceEpoch);
    return temp;
  }

  Future<void> loadData() async {
    users = await Api().loadUsers();
    chats = await Api().loadChats();
    items = await Api().loadChatItems();
    state = Load.good;
    setFitler("");
  }

  String getImage(String user) {
    return users.where((element) => element.userUID == user).first.avatar;
  }

  User getUser(String id) {
    return users.where((element) => element.userUID == id).first;
  }
}

class Api {
  Future<List<User>> loadUsers() async {
    List<User> users = [];
    try {
      List<Map<String, dynamic>> res =
          await GetIt.I.get<Supabase>().client.from('Users').select('*');
      GetIt.I.get<Talker>().debug(res);
      for (var element in res) {
        users.add(User.fromMap(element));
      }
      GetIt.I.get<Talker>().debug(res);
    } catch (err) {
      GetIt.I.get<Talker>().debug(err);
      return Future.error("error");
    }
    return users;
  }

  Future<List<Chat>> loadChats() async {
    List<Chat> chats = [];
    try {
      List<Map<String, dynamic>> res =
          await GetIt.I.get<Supabase>().client.from('Chats').select('*');
      GetIt.I.get<Talker>().debug(res);
      for (var element in res) {
        chats.add(Chat.fromMap(element));
      }
      GetIt.I.get<Talker>().debug(res);
    } catch (err) {
      GetIt.I.get<Talker>().debug(err);
      return Future.error("error");
    }
    return chats;
  }

  Future<List<ChatItem>> loadChatItems() async {
    List<ChatItem> itemss = [];
    try {
      List<Map<String, dynamic>> res =
          await GetIt.I.get<Supabase>().client.from('ChatItem').select('*');
      GetIt.I.get<Talker>().debug(res);
      for (var element in res) {
        itemss.add(ChatItem.fromMap(element));
      }
      GetIt.I.get<Talker>().debug(res);
    } catch (err) {
      GetIt.I.get<Talker>().debug(err);
      return Future.error("error");
    }
    return itemss;
  }
}

class Chat {
  final int id;
  final String user;
  final String driver;

  Chat({required this.id, required this.user, required this.driver});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'driver': driver,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] as int,
      user: map['user'] as String,
      driver: map['driver'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChatItem {
  final int id;
  final int chat_id;
  final String msg;
  final String by_user;
  final bool is_readed;
  final DateTime write_time;

  ChatItem(
      {required this.id,
      required this.chat_id,
      required this.msg,
      required this.by_user,
      required this.is_readed,
      required this.write_time});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'chat_id': chat_id,
      'msg': msg,
      'by_user': by_user,
      'is_readed': is_readed,
      'write_time': write_time.millisecondsSinceEpoch,
    };
  }

  factory ChatItem.fromMap(Map<String, dynamic> map) {
    return ChatItem(
      id: map['id'] as int,
      chat_id: map['chat_id'] as int,
      msg: map['msg'] as String,
      by_user: map['by_user'] as String,
      is_readed: map['is_readed'] as bool,
      write_time: DateTime.parse(map['write_time'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatItem.fromJson(String source) =>
      ChatItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

class User {
  final String userUID;
  final String name;
  final int balance;
  final String phone;
  final String address;
  String avatar;

  User(this.userUID, this.name, this.balance, this.phone, this.address,
      this.avatar);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUID': userUID,
      'name': name,
      'balance': balance,
      'phone': phone,
      'address': address,
      'avatar': avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['userUID'] as String,
      map['name'] as String,
      map['balance'] as int,
      map['phone'] as String,
      map['address'] as String,
      map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum Load { failed, good, loading }
