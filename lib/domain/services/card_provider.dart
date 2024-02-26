import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier{
  back(context){
    Navigator.of(context).pop();
  }
}