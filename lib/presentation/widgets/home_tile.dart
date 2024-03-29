import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/providers/home_page_provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';

class HomeTile extends StatefulWidget {
  final HomeTileModel data;

  const HomeTile({
    super.key,
    required this.data,
  });

  @override
  State<HomeTile> createState() => _HomeTIleState();
}

class _HomeTIleState extends State<HomeTile> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomePageProvider>();
    return GestureDetector(
      onTap: () => provider.onTileTap(widget.data.tag, context),
      onLongPress: () {
        setState(() {
          selected = !selected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 159.w,
        padding: const EdgeInsets.all(8),
        height: 159.h,
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
            SizedBox(
              height: 6.h,
            ),
            Text(
              widget.data.tittle,
              style: Fa.text4_500_16
                  .copyWith(color: selected ? Colors.white : Ca.primary),
            ),
            SizedBox(
              height: 6.h,
            ),
            SizedBox(
              width: 127.w,
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
