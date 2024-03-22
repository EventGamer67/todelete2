import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/providers/chat_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserChatScreen extends StatefulWidget {
  final int chatID;
  const UserChatScreen({super.key, required this.chatID});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  @override
  Widget build(BuildContext context) {
    ChatProvider provider = context.watch<ChatProvider>();
    List<ChatItem> messages = provider.getChatMessages(widget.chatID);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            child: Text("a"),
            onTap: () => launchUrlString('tel:${widget.chatID}'),
          ),
        ),
        body: Column(
            children: List.generate(messages.length, (index) {
          return Text(messages[index].msg);
        })));
  }
}
