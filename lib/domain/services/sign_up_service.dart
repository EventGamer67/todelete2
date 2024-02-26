import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todelete2/presentation/screens/sign_in_screen.dart';

class SignUpService extends ChangeNotifier {
  String fio = "";
  String phone = "";
  String email = "";
  String password = "";
  String confpassword = "";
  bool terms = false;

  bool correct = false;

  check() {
    bool result = true;
    result = terms;

    if (fio.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confpassword.isEmpty) {
      result = false;
    }

    GetIt.I.get<Talker>().debug(fio);

    if (password != confpassword) {
      result = false;
    }

    correct = result;
    notifyListeners();
  }

  openTerms(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SfPdfViewer.asset("assets/pdf/test.pdf")));
  }

  swTerms() {
    terms = !terms;
    check();
  }

  signUp() {}

  signIn(context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInWrapper()));
  }

  googleIn() {
    GetIt.I.get<Supabase>().client.auth.signInWithOAuth(OAuthProvider.google);
  }
}
