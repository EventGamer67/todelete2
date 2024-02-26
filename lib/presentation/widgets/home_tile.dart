
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todelete2/domain/services/home_page_provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';

class HomeTile extends StatefulWidget {
  final HomeTileModel data;
  
  const HomeTile({
    super.key, required this.data,
  });

  @override
  State<HomeTile> createState() => _HomeTIleState();
}

class _HomeTIleState extends State<HomeTile> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          selected = !selected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 159,
        padding: const EdgeInsets.all(8),
        height: 159,
        decoration: BoxDecoration(
            color: selected ? Ca.primary : const Color(0xFFF2F2F2),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.15))
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              widget.data.image,
              color: selected ? Colors.white : Ca.primary,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              widget.data.tittle,
              style: Fa.text4_500_16
                  .copyWith(color: selected ? Colors.white : Ca.primary),
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              width: 127,
              child: Text(
                widget.data.des,
                style: Fa.text4_400_16.copyWith(
                    fontSize: 7.45, color: selected ? Colors.white : Ca.text4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}