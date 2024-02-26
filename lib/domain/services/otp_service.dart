import 'package:flutter/material.dart';
import 'package:todelete2/presentation/screens/reset_screen.dart';

class OTPService extends ChangeNotifier {
  String code = "";
  bool correct = false;
  String valid = "123456";

  setCode(String cod) {
    code = cod;
    check();
  }

  check() {
    correct = valid == code;
    notifyListeners();
  }

  reset(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResetWrapper() ));
  }
}
