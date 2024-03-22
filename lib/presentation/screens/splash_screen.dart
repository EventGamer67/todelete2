import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todelete2/presentation/screens/main_screen.dart';
import 'package:todelete2/presentation/screens/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _goToNext(context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (GetIt.I.get<Supabase>().client.auth.currentUser != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreenWrapper()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnBoardWrapper()));
    }
  }

  @override
  void initState() {
    super.initState();
    _goToNext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SvgPicture.asset("assets/images/Logo.svg"),
      ),
    );
  }
}
