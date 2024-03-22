import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todelete2/domain/providers/chat_provider.dart' as pr;
import 'package:todelete2/domain/providers/home_page_provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'package:todelete2/presentation/widgets/home_tile.dart';

class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageProvider(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final provider = context.watch<HomePageProvider>();
    final chat = context.watch<pr.ChatProvider>();
    return Scaffold(
      backgroundColor: themeProvider.theme.colorScheme.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 34,
                decoration: BoxDecoration(
                    color: themeProvider.isDark ? Ca.gray1 : Ca.gray1,
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration.collapsed(
                            hintText: "Search services",
                            hintStyle: Fa.gray2_400_14.copyWith(
                              fontSize: 12,
                            )),
                      ),
                    ),
                    SvgPicture.asset(
                        "assets/images/vuesax_linear_search-normal.svg")
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 91,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          chat.users
                              .where((element) =>
                                  element.userUID ==
                                  "645718b6-32e8-4c38-86ea-3bce5a1a5adf")
                              .first
                              .avatar,
                        ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? file =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (file != null) {
                          String code = GetIt.I
                              .get<Supabase>()
                              .client
                              .auth
                              .currentUser!
                              .id;
                          await GetIt.I
                              .get<Supabase>()
                              .client
                              .storage
                              .from("dsa")
                              .remove(["${code}/${file.name}"]);
                          await GetIt.I
                              .get<Supabase>()
                              .client
                              .storage
                              .from("dsa")
                              .uploadBinary(
                                  fileOptions: FileOptions(upsert: true),
                                  "${code}/${file.name}",
                                  await file.readAsBytes());
                          String url = GetIt.I
                              .get<Supabase>()
                              .client
                              .storage
                              .from('dsa')
                              .getPublicUrl("${code}/${file.name}");
                          GetIt.I
                              .get<Supabase>()
                              .client
                              .from('Users')
                              .update({"avatar": "${url}"}).eq('user',
                                  "645718b6-32e8-4c38-86ea-3bce5a1a5adf");
                          pr.User us = chat.users
                              .where((element) =>
                                  element.userUID ==
                                  "645718b6-32e8-4c38-86ea-3bce5a1a5adf")
                              .first;
                          us.avatar = url;
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/Frame 83.png"),
                            ),
                            border: Border.all(width: 1, color: Ca.gray1)),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Hello Ken!",
                          style: Fa.primary_700_24.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        Text(
                          "  We trust you are having a great time",
                          style: Fa.gray1_400_12,
                        )
                      ],
                    )),
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          "assets/images/vuesax_linear_notification-2.svg",
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 39,
              ),
              SpecialForYouBlock(),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialForYouBlock extends StatefulWidget {
  const SpecialForYouBlock({
    super.key,
  });

  @override
  State<SpecialForYouBlock> createState() => _SpecialForYouBlockState();
}

class _SpecialForYouBlockState extends State<SpecialForYouBlock> {
  @override
  Widget build(BuildContext context) {
    HomePageProvider provider =
        Provider.of<HomePageProvider>(context, listen: true);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Special for you",
              style: Fa.text4_500_14.copyWith(color: Ca.secondary),
            ),
            SvgPicture.asset("assets/images/arrow-square-right-2.svg")
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        SizedBox(
          height: 64,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: provider.ads.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  width: 166,
                  height: 64,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              provider.ads[index].image),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(width: 1, color: Ca.secondary)),
                );
              }),
        ),
        const SizedBox(
          height: 29,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What would you like to do",
                  style: Fa.gray1_500_14.copyWith(color: Ca.primary),
                )),
            const SizedBox(
              height: 9,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 23,
                    mainAxisSpacing: 23),
                itemCount: provider.tiles.length,
                itemBuilder: (context, index) {
                  return HomeTile(
                    data: provider.tiles[index],
                  );
                })
          ],
        ),
        const SizedBox(
          height: 45,
        )
      ],
    );
  }
}
