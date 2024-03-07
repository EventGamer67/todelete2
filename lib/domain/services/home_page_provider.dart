import 'package:flutter/material.dart';
import 'package:todelete2/presentation/screens/send_a_package_screen.dart';

class HomePageProvider extends ChangeNotifier {
  onTileTap(String tag, BuildContext context) {
    switch (tag) {
      case "send":
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SendAPackageWrapper()));
        }
    }
  }

  List<HomeTileModel> tiles = [
    HomeTileModel(
        image: "assets/images/healthicons_call-centre.svg",
        tittle: "Customer Care",
        des:
            "Our customer care service line is available from 8 -9pm week days and 9 - 5 weekends - tap to call us today",
        tag: "customer"),
    HomeTileModel(
        image: "assets/images/codicon_package.svg",
        tittle: "Send a package",
        des: "Request for a driver to pick up or deliver your package for you",
        tag: "send"),
    HomeTileModel(
        image: "assets/images/Vector-2.svg",
        tittle: "Fund your wallet",
        des:
            "To fund your wallet is as easy as ABC, make use of our fast technology and top-up your wallet today",
        tag: "customer"),
    HomeTileModel(
        image: "assets/images/Vector-3.svg",
        tittle: "Chats",
        des: "Search for available rider within your area",
        tag: "customer")
  ];
}

class HomeTileModel {
  final String image;
  final String tittle;
  final String des;
  final String tag;

  HomeTileModel(
      {required this.tag,
      required this.image,
      required this.tittle,
      required this.des});
}
