import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todelete2/presentation/screens/forgot_screen.dart';
import 'package:todelete2/presentation/screens/sign__up_screen.dart';

class SignInService extends ChangeNotifier {
  String email = "";
  String password = "";
  bool correct = false;
  bool remember = false;

  logIn() {}

  googleIn() async {
    final Supabase supa = GetIt.I.get<Supabase>();
    final Talker talker = GetIt.I.get<Talker>();
    GoogleSignIn sign = GoogleSignIn(
      clientId: "989762417628-ro6boqvejdfgdda1v1d64mu681l04f63.apps.googleusercontent.com"
    );
    GoogleSignInAccount? acc = await sign.signIn();
    talker.debug(acc);
    if(acc != null){
      talker.debug(acc.email);
      GoogleSignInAuthentication auth = await acc.authentication;
      talker.debug(auth.accessToken);
      talker.debug(auth.idToken);

      AuthResponse response = await supa.client.auth.signInWithIdToken(provider: OAuthProvider.google, accessToken:auth.accessToken!, idToken: auth.idToken!);
      talker.debug(response.user!.email);
    }

    // const List<String> scopes = <String>[
    //   'email',
    //   'https://www.googleapis.com/auth/contacts.readonly',
    // ];

    // GoogleSignIn sign = GoogleSignIn(
    //     scopes: scopes,
    //     serverClientId:
    //         "989762417628-ro6boqvejdfgdda1v1d64mu681l04f63.apps.googleusercontent.com");
    // GoogleSignInAccount? res = await sign.signIn();
    // GetIt.I.get<Talker>().debug(res);
    // final GoogleSignInAuthentication? auth = await res!.authentication;

    // GetIt.I.get<Supabase>().client.auth.signInWithIdToken(
    //     provider: OAuthProvider.google,
    //     idToken: "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",
    //     accessToken: "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");
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
