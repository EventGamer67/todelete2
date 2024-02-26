import 'package:flutter/material.dart';
import 'package:todelete2/presentation/styles/fonts.dart';

class ScreenHeader extends StatelessWidget {
  final String tittle;
  final String desc;
  const ScreenHeader({super.key, required this.tittle, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: Fa.text4_500_16.copyWith(fontSize: 24),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(desc, style: Fa.gray2_500_14),
      ],
    );
  }
}
