import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class BaseProvider extends ChangeNotifier {
  switchAvatar() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    SupabaseClient client = GetIt.I.get<Supabase>().client;
    await client.storage.from('default').upload('avatars/${file.name}', File(file.path));
    GetIt.I.get<Talker>().debug(client.storage.from('default').getPublicUrl('avatars/${file.name}'));
  }

  bool internet = false;
  late StreamSubscription listner;
  BaseProvider() {
    listner = InternetConnection().onStatusChange.listen((event) {
      internet = (event == InternetStatus.connected ? true : false);
    });
  }

  checkInternet(BuildContext context) {
    if (!internet) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(internet ? "Онлайн" : "Нет интернета")));
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Нет интернета"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Ок"))
                ],
              ));
      return false;
    } else {
      return true;
    }
  }
}
