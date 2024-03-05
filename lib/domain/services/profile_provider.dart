// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todelete2/presentation/screens/card_screen.dart';
import 'package:todelete2/presentation/screens/notification_screen.dart';
import 'package:todelete2/presentation/styles/fonts.dart';

class ProfileProvider extends ChangeNotifier {
  tapTile(BuildContext context,String tag) {
    GetIt.I.get<Talker>().debug(tag);
    switch (tag) {
      case "edit":
        {}
      case "trans":
        {}
      case "notif":
        {Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationScreen() ));}
      case "card":
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CardScreenWrapper() ));
        }
      case "ref":
        {}
      case "about":
        {}
      case "logout":
        {}
    }
  }

  List<ProfileTile> tiles = [
    ProfileTile(
      image: "assets/images/iconoir_profile-circled.svg",
      des: "Name, phone no, address, email ...",
      tittle: "Edit Profile",
      tag: "edit",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "assets/images/healthicons_i-certificate-paper-outline.svg",
      des: "Download transaction details, orders, deliveries",
      tittle: "Statements & Reports",
      tag: "trans",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "assets/images/vuesax_linear_notification.svg",
      des: "mute, unmute, set location & tracking setting",
      tittle: "Notification Settings",
      tag: "notif",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "assets/images/vuesax_linear_wallet-2.svg",
      des: "change cards, delete card details",
      tittle: "Card & Bank account settings",
      tag: "card",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "assets/images/carbon_two-person-lift.svg",
      des: "check no of friends and earn",
      tittle: "Referrals",
      tag: "ref",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "assets/images/map.svg",
      des: "know more about us, terms and conditions",
      tittle: "About Us",
      tag: "about",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "assets/images/ic_round-log-out.svg",
      tittle: "Log Out",
      tag: "logout",
      height: 50,
      lightcolor: Ca.error,
      darkColor: Ca.error,
    )
  ];
}

class ProfileTile {
  final String image;
  final String tittle;
  String? des;
  final String tag;
  final double height;
  final Color lightcolor;
  final Color darkColor;

  ProfileTile(
      {required this.image,
      required this.tittle,
      this.des,
      required this.tag,
      required this.height,
      required this.lightcolor,
      required this.darkColor});
}
