
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String tittle;
  final bool back;
  const MyAppBar({
    super.key,
    required this.tittle,
    required this.back,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    return AppBar(
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: SizedBox(
          width: 24,
          height: 24,
          child: back? FittedBox(
            fit: BoxFit.scaleDown,
            child: SvgPicture.asset("assets/images/arrow-square-right.svg"),
          ) : null,
        ),
      ),
      shadowColor: Colors.black,
      surfaceTintColor: themeProvider.isDark ? Ca.prishade2 : Colors.white,
      centerTitle: true,
      backgroundColor: themeProvider.isDark ? Ca.prishade2 : Colors.white,
      title: Text(
        tittle,
        style: Fa.gray2_500_16,
      ),
      elevation: 2,
    );
  }
}