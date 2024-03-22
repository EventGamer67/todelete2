import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todelete2/domain/providers/chat_provider.dart';
import 'package:todelete2/presentation/screens/screens/user_chat.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'package:todelete2/presentation/widgets/myappbar_widget.dart';

class ChatWrapper extends StatelessWidget {
  const ChatWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatScreen();
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    ChatProvider chatprovider = context.watch<ChatProvider>();
    GetIt.I.get<Talker>().debug("msg");
    return Scaffold(
        backgroundColor: themeProvider.isDark ? Ca.prishade1 : Colors.white,
        appBar: const MyAppBar(
          tittle: "Chats",
          back: true,
        ),
        body: Builder(
          builder: (context) {
            if (chatprovider.state == Load.failed) {
              return const Text("load fauled");
            } else if (chatprovider.state == Load.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (chatprovider.state == Load.good) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 21.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: 40,
                      decoration: BoxDecoration(
                          color: themeProvider.isDark ? Ca.gray1 : Ca.gray1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                onChanged: (val) {
                                  chatprovider.setFitler(val);
                                },
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Search for a driver",
                                    hintStyle: Fa.gray2_400_14.copyWith(
                                      fontSize: 12,
                                    )),
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                              "assets/images/vuesax_linear_search-normal.svg")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Column(
                      children: List.generate(chatprovider.filteredChats.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserChatScreen(chatID: chatprovider.filteredChats[index].id)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            padding: const EdgeInsets.all(8),
                            height: 84.2.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: Ca.gray2)),
                            child: Row(
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color: Ca.gray1,
                                          strokeAlign:
                                              BorderSide.strokeAlignInside),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            chatprovider.getImage(chatprovider
                                                    .filteredChats[index]
                                                    .driver ??
                                                "https://nhqkdabncpfkducyfdzw.supabase.co/storage/v1/object/public/default/avatars/1000000049.jpg")),
                                      )),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(chatprovider
                                        .getUser(chatprovider
                                            .filteredChats[index].driver)
                                        .name),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    chatprovider
                                            .getChatMessages(chatprovider
                                                .filteredChats[index].id)
                                            .isNotEmpty
                                        ? Text(chatprovider
                                            .getChatMessages(chatprovider
                                                .filteredChats[index].id)[0]
                                            .msg)
                                        : SizedBox(),
                                  ],
                                )),
                                chatprovider
                                            .getChatMessages(chatprovider
                                                .filteredChats[index].id)
                                            .where(
                                              (element) =>
                                                  element.is_readed == false,
                                            )
                                            .toList()
                                            .length >
                                        0
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          child: Center(
                                            child: Text(
                                              "${chatprovider.getChatMessages(chatprovider.filteredChats[index].id).where(
                                                    (element) =>
                                                        element.is_readed ==
                                                        false,
                                                  ).toList().length}",
                                              style: Fa.gray2_500_14.copyWith(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Ca.primary),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              );
            }
            return Text("data");
          },
        ));
  }
}
