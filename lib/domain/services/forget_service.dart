import 'package:flutter/material.dart';
import 'package:todelete2/presentation/screens/otp_screen.dart';
import 'package:todelete2/presentation/screens/sign_in_screen.dart';
import 'package:email_validator/email_validator.dart';

class ForgetService extends ChangeNotifier {
  String email = "";
  bool correct = false;
  check() {
    correct = emailCorrect(email);
    notifyListeners();
  }

  sendOTP(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OTPWrapper() ));
  }

  signIn(context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInWrapper()));
  }
}

bool emailCorrect(String email) {
  try {
    bool correct = EmailValidator.validate(email);
    if (correct) {
      if (email.split('@')[1].toLowerCase() == email.split('@')[1]) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (err) {
    return false;
  }
}
