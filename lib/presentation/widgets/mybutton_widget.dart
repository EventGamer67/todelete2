import 'package:flutter/material.dart';
import 'package:todelete2/presentation/styles/fonts.dart';

class MyButton extends StatelessWidget {
  final bool filled;
  final String text;
  final double width;
  final double height;
  final bool enabled;
  final Function onTap;

  const MyButton(
      {super.key,
      required this.filled,
      required this.text,
      required this.width,
      required this.height,
      required this.enabled,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: filled ? null : Border.all(width: 1, color: Ca.primary),
            color:
                filled ? (enabled ? Ca.primary : Ca.gray2) : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(4.69))),
        child: Center(
          child: Text(
            text,
            style: Fa.primary_700_24.copyWith(
                color: !filled ? Ca.primary : Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
