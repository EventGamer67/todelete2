import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todelete2/data/model/boardpage_model.dart';
import 'package:todelete2/presentation/screens/sign__up_screen.dart';

class OnBoardService extends ChangeNotifier {
  late final PageController controller;
  late AnimationController anim;
  BoardPage current =
      BoardPage(tittle: "tittle", descr: "descr", image: "image");
  List<BoardPage> queue = [];
  bool isQueueEmpty = false;

  OnBoardService(BuildContext context) {
    loadQueue(context);
    controller = PageController();
  }

  loadQueue(context) {
    List<String>? data =
        GetIt.I.get<SharedPreferences>().getStringList("onboard");
    if (data == null) {
      queue = sample;
    } else {
      for (var element in data) {
        queue.add(BoardPage.fromJson(element));
      }
    }
    if (queue.isNotEmpty) {
      current = queue.first;
    } else {
      Future.delayed(Duration.zero).then((value) => signUp(context));
    }
  }

  saveQueue() {
    List<String> data = [];
    for (var page in queue) {
      data.add(page.toJson());
    }
    GetIt.I.get<SharedPreferences>().setStringList("onboard", data);
  }

  onboardViewed() {
    GetIt.I.get<SharedPreferences>().setStringList("onboard", []);
  }

  next() async {
    await anim.animateTo(0, duration: const Duration(milliseconds: 150));
    extractPage();
    notifyListeners();
    await anim.animateTo(1, duration: const Duration(milliseconds: 150));
  }

  extractPage() {
    if (queue.isNotEmpty) {
      queue.removeAt(0);
      current = queue.first;
      saveQueue();
    }
    if (queue.isEmpty) {
      isQueueEmpty = true;
      onboardViewed();
    }
  }

  skip(context) {
    onboardViewed();
    signIn(context);
  }

  signUp(context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignUpWrapper()));
  }

  signIn(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Placeholder()));
  }
}

List<BoardPage> sample = [
  BoardPage(
      tittle: "Quick Delivery At Your Doorstep",
      descr: "Enjoy quick pick-up and delivery to your destination",
      image: "assets/images/board1.svg"),
  BoardPage(
      tittle: "Flexible Payment",
      descr:
          "Different modes of payment either before and after delivery without stress",
      image: "assets/images/board2.svg"),
  BoardPage(
      tittle: "Real-time Tracking",
      descr:
          "Track your packages/items from the comfort of your home till final destination",
      image: "assets/images/board3.svg"),
];
