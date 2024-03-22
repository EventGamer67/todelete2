import 'package:flutter/material.dart';
import 'package:todelete2/presentation/screens/main_screen.dart';

class ResetService extends ChangeNotifier {
  String password = "";
  String confPassword = "";

  bool correct = false;

  setPassword(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScreenWrapper() ));
  }

  check() {
    if (password == confPassword) {
      correct = true;
    } else {
      correct = false;
    }
    if(password.isEmpty || confPassword.isEmpty){
      correct = false;
    }
    notifyListeners();
  }
}
