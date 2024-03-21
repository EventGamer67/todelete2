// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:todelete2/presentation/screens/send_a_package_screen.dart';


class Advertisment {
  final String image;
  final int id;

  Advertisment({required this.image, required this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageURL': image,
    };
  }

  factory Advertisment.fromMap(Map<String, dynamic> map) {
    return Advertisment(
      image: map['imageURL'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Advertisment.fromJson(String source) =>
      Advertisment.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<T> parse<T>(List<Map<String, dynamic>> json,
    T Function(Map<String, dynamic>) constructor) {
  List<T> list = [];
  for (var element in json) {
    list.add(constructor(element));
  }
  return list;
}

class HomePageProvider extends ChangeNotifier {
  List<Advertisment> ads = [];

  HomePageProvider() {
    loadAds();
  }

  loadAds() async {
    final data =
        await GetIt.I.get<Supabase>().client.from('Advertisement').select('*');
    GetIt.I.get<Talker>().debug(data);

    ads = parse<Advertisment>(data, Advertisment.fromMap);
    ads.sort((a,b) => a.id - b.id );
    GetIt.I.get<Talker>().debug(ads[0].image);
    notifyListeners();
  }

  onTileTap(String tag, BuildContext context) {
    switch (tag) {
      case "send":
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SendAPackageWrapper()));
        }
    }
  }

  List<HomeTileModel> tiles = [
    HomeTileModel(
        image: "assets/images/healthicons_call-centre.svg",
        tittle: "Customer Care",
        des:
            "Our customer care service line is available from 8 -9pm week days and 9 - 5 weekends - tap to call us today",
        tag: "customer"),
    HomeTileModel(
        image: "assets/images/codicon_package.svg",
        tittle: "Send a package",
        des: "Request for a driver to pick up or deliver your package for you",
        tag: "send"),
    HomeTileModel(
        image: "assets/images/Vector-2.svg",
        tittle: "Fund your wallet",
        des:
            "To fund your wallet is as easy as ABC, make use of our fast technology and top-up your wallet today",
        tag: "customer"),
    HomeTileModel(
        image: "assets/images/Vector-3.svg",
        tittle: "Chats",
        des: "Search for available rider within your area",
        tag: "customer")
  ];
}

class HomeTileModel {
  final String image;
  final String tittle;
  final String des;
  final String tag;

  HomeTileModel(
      {required this.tag,
      required this.image,
      required this.tittle,
      required this.des});
}
