// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todelete2/presentation/screens/pages/home_page.dart';
import 'package:todelete2/presentation/screens/pages/profile.page.dart';

class MainProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<BarItem> bar = [
    BarItem(
        name: "Home",
        activeIcon: "assets/images/house-2 (2).svg",
        deactiveIcon: "assets/images/vuesax_linear_house-2.svg",
        page: HomePageWrapper()),
    BarItem(
        name: "Wallet",
        activeIcon: "assets/images/vuesax_linear_wallet-3 (3).svg",
        deactiveIcon: "assets/images/vuesax_linear_wallet-3 (2).svg",
        page: Placeholder()),
    BarItem(
        name: "Track",
        activeIcon: "assets/images/vuesax_linear_smart-car (3).svg",
        deactiveIcon: "assets/images/vuesax_linear_smart-car (2).svg",
        page: Placeholder()),
    BarItem(
        name: "Profile",
        activeIcon: "assets/images/vuesax_linear_profile-circle (1).svg",
        deactiveIcon: "assets/images/profile-circle (1).svg",
        page: ProfileWrapper())
  ];

  setActive(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

class BarItem {
  String name;
  String activeIcon;
  String deactiveIcon;
  Widget page;
  BarItem(
      {required this.name,
      required this.activeIcon,
      required this.deactiveIcon,
      required this.page});
}
