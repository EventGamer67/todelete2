import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/providers/profile_provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'package:todelete2/presentation/widgets/myappbar_widget.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    ProfileProvider provider = context.watch<ProfileProvider>();
    return Scaffold(
      backgroundColor: themeProvider.isDark ? Ca.prishade1 : Colors.white,
      appBar: const MyAppBar(tittle: "Profile", back: false,),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 27,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ProfileBlock()),
              const SizedBox(
                height: 19,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ThemeSwitchBlock(themeProvider: themeProvider),
                    const SizedBox(
                      height: 19,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.tiles.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    provider.tapTile(context,provider.tiles[index].tag),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: provider.tiles[index].height,
                                  decoration: BoxDecoration(
                                      color: themeProvider.isDark
                                          ? Ca.prishade2
                                          : Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.15),
                                            offset: const Offset(0, 2),
                                            blurRadius: 5)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        provider.tiles[index].image,
                                        color: themeProvider.isDark
                                            ? provider.tiles[index].darkColor
                                            : provider.tiles[index].lightcolor,
                                      ),
                                      const SizedBox(
                                        width: 9,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            provider.tiles[index].tittle,
                                            style: Fa.text4_500_16.copyWith(
                                                color: themeProvider.isDark
                                                    ? Colors.white
                                                    : Ca.text4),
                                          ),
                                          provider.tiles[index].des != null
                                              ? Text(
                                                  provider.tiles[index].des!,
                                                  style: Fa.gray2_400_14
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: themeProvider
                                                                  .isDark
                                                              ? Colors.white
                                                              : Ca.gray2),
                                                )
                                              : const SizedBox()
                                        ],
                                      )),
                                      SvgPicture.asset(
                                          color: themeProvider.isDark
                                              ? Colors.white
                                              : Ca.text4,
                                          "assets/images/Vector (14).svg")
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ],
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeSwitchBlock extends StatelessWidget {
  const ThemeSwitchBlock({
    super.key,
    required this.themeProvider,
  });

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Enable dark Mode",
          style: Fa.text4_500_16
              .copyWith(color: themeProvider.isDark ? Colors.white : Ca.text4),
        ),
        SizedBox(
            height: 35,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Switch.adaptive(
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Ca.gray2,
                value: themeProvider.isDark,
                activeColor: Colors.white,
                activeTrackColor: Ca.primary,
                trackOutlineColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                onChanged: (value) {
                  themeProvider.switchTheme();
                },
              ),
            ))
      ],
    );
  }
}

class ProfileBlock extends StatefulWidget {
  const ProfileBlock({
    super.key,
  });

  @override
  State<ProfileBlock> createState() => _ProfileBlockState();
}

class _ProfileBlockState extends State<ProfileBlock> {
  bool hided = false;
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    return Container(
      height: 75,
      padding: const EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Ca.gray1,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignInside),
                shape: BoxShape.circle,
                image: const DecorationImage(
                    image: AssetImage("assets/images/latest.png"))),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Ken",
                style: Fa.text4_500_16.copyWith(
                    color: themeProvider.isDark ? Colors.white : Ca.text4),
              ),
              Row(
                children: [
                  Text(
                    "Current balance: ",
                    style: Fa.text4_500_14.copyWith(
                        fontSize: 12,
                        color: themeProvider.isDark ? Colors.white : Ca.text4),
                  ),
                  Text(
                    hided
                        ? ("N10,712:00")
                            .characters
                            .map((e) => "*")
                            .toList()
                            .join()
                        : "N10,712:00",
                    style: Fa.text4_500_14
                        .copyWith(fontSize: 12, color: Ca.primary),
                  ),
                ],
              ),
            ],
          )),
          GestureDetector(
              onTap: () {
                setState(() {
                  hided = !hided;
                });
              },
              child: SvgPicture.asset(
                  "assets/images/vuesax_linear_eye-slash.svg",
                  color: themeProvider.isDark ? Colors.white : Ca.text4))
        ],
      ),
    );
  }
}
