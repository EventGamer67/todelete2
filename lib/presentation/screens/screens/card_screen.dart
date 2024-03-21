import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/providers/card_provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'package:todelete2/presentation/widgets/myappbar_widget.dart';

class CardScreenWrapper extends StatelessWidget {
  const CardScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: const CardScreen(),
    );
  }
}

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    CardProvider provider = context.watch<CardProvider>();
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: const MyAppBar(tittle: "Add Payment method",back: true,),
      backgroundColor: themeProvider.isDark ? Ca.prishade1 : Colors.white,
      body: Container(),
    );
  }
}
