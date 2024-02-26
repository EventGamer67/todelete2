import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/services/main_provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';

class MainScreenWrapper extends StatelessWidget {
  const MainScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    MainProvider provider = context.watch<MainProvider>();
    return Scaffold(
      backgroundColor: themeProvider.isDark ? Ca.prishade2 : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: provider.bar[provider.currentIndex].page),
            Container(
              height: 60,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: const Offset(0, -4),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.05))
              ], color: themeProvider.isDark ? Ca.prishade2 : Colors.white),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(provider.bar.length, (index) {
                    return GestureDetector(
                      onTap: () => provider.setActive(index),
                      child: SizedBox(
                        width: 35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: provider.currentIndex == index ? 1 : 0,
                              child: Container(
                                width: 35,
                                height: 2,
                                decoration: const BoxDecoration(
                                    color: Ca.primary,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Ca.primary,
                                          offset: Offset(0, 1),
                                          blurRadius: 2)
                                    ]),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SvgPicture.asset(index == provider.currentIndex
                                ? provider.bar[index].activeIcon
                                : provider.bar[index].deactiveIcon,),
                            FittedBox(
                              child: Text(
                                provider.bar[index].name,
                                style: Fa.yellow_400_12.copyWith(
                                    color: provider.currentIndex == index
                                        ? Ca.primary
                                        : Ca.gray2),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
