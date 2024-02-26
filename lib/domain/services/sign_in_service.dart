import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todelete2/presentation/screens/forgot_screen.dart';
import 'package:todelete2/presentation/screens/sign__up_screen.dart';

class SignInService extends ChangeNotifier {
  String email = "";
  String password = "";
  bool correct = false;
  bool remember = false;

  logIn() {}

  googleIn() {
    GetIt.I.get<Supabase>().client.auth.signInWithOAuth(OAuthProvider.google);
  }

  signUp(context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignUpWrapper()));
  }

  check() {}

  swRemember() {
    remember = !remember;
    notifyListeners();
  }

  forgot(context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ForgetWrapper()));
  }
}
