// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todelete2/presentation/styles/fonts.dart';

class ProfileProvider extends ChangeNotifier {
  List<ProfileTile> tiles = [
    ProfileTile(
      image: "image",
      des: "as",
      tittle: "tittle",
      tag: "tag",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "image",
      des: "as",
      tittle: "tittle",
      tag: "tag",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "image",
      des: "as",
      tittle: "tittle",
      tag: "tag",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "image",
      des: "as",
      tittle: "tittle",
      tag: "tag",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "image",
      des: "as",
      tittle: "tittle",
      tag: "tag",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "image",
      des: "as",
      tittle: "tittle",
      tag: "tag",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    ),
    ProfileTile(
      image: "image",
      des: "as",
      tittle: "tittle",
      tag: "tag",
      height: 60,
      lightcolor: Ca.text4,
      darkColor: Colors.white,
    )
  ];
}

class ProfileTile {
  final String image;
  final String tittle;
  final String des;
  final String tag;
  final double height;
  final Color lightcolor;
  final Color darkColor;

  ProfileTile(
      {required this.image,
      required this.tittle,
      required this.des,
      required this.tag,
      required this.height,
      required this.lightcolor,
      required this.darkColor});
}
