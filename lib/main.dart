import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todelete2/domain/providers/base_provider.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'package:todelete2/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<Talker>(TalkerFlutter.init());

  GetIt.I.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  final Supabase supa = await Supabase.initialize(
      url: "https://nhqkdabncpfkducyfdzw.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ocWtkYWJuY3Bma2R1Y3lmZHp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcyMDY5OTgsImV4cCI6MjAyMjc4Mjk5OH0.bPsz10JKZPuvzJquNhKCFch9-6AfzQuZhUUfivo7WZU");
  GetIt.I.registerSingleton<Supabase>(supa);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseProvider>(
          create: (context) => BaseProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider())
      ],
      builder: (context, child) {
        return ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            designSize: const Size(390, 844),
            builder: (context, child) {
              return MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: Provider.of<ThemeProvider>(context).theme,
                  home: child);
            },
            child: const SplashScreen());
      },
    );
  }
}
