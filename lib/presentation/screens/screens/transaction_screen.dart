import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'dart:math';

class TransactionScreenWrapper extends StatelessWidget {
  const TransactionScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionScreen();
  }
}

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controller.repeat();
    Future.delayed(const Duration(seconds: 4)).then((value) {
      GetIt.I.get<Talker>().debug("FINISH");
      controller.stop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    GetIt.I.get<Talker>().debug(controller.value);
    return Scaffold(
      backgroundColor: themeProvider.isDark ? Ca.prishade1 : Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: RotationTransition(
                turns: controller,
                child: Image.asset("assets/images/Component 21.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
