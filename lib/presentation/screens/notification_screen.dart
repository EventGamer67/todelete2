import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'package:todelete2/presentation/widgets/myappbar_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: const MyAppBar(back: true, tittle: "Notification"),
      backgroundColor: themeProvider.isDark ? Ca.prishade1 : Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                  "assets/images/vuesax_linear_notification-2.svg", color: themeProvider.isDark ? Colors.white : Ca.gray2,)),
          const SizedBox(
            height: 18,
          ),
          Text(
            "You have no notifications",
            style: Fa.text4_500_16.copyWith(color: themeProvider.isDark ? Colors.white : Ca.text4),
          )
        ],
      ),
    );
  }
}
