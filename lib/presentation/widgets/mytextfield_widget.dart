import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todelete2/presentation/styles/fonts.dart';

class Mytextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String tittle;
  final String hint;
  final bool hidable;
  final Function onChanged;
  final Function? validator;

  const Mytextfield(
      {super.key,
      this.controller,
      this.validator,
      required this.onChanged,
      required this.tittle,
      required this.hint,
      required this.hidable});

  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  bool hided = false;
  bool correct = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.tittle,
          style: Fa.gray2_500_14,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 44,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border:
                  Border.all(width: 1, color: correct ? Ca.gray2 : Ca.error)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        correct = widget.validator?.call(value) ?? true;
                        widget.onChanged.call(value);
                      },
                      controller: widget.controller,
                      style: Fa.text4_500_14,
                      obscureText: hided,
                      decoration: InputDecoration.collapsed(
                          hintText: widget.hint,
                          hintStyle: correct
                              ? Fa.gray1_500_14
                              : Fa.gray1_500_14.copyWith(color: Ca.error)),
                    ),
                  ),
                  widget.hidable
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              hided = !hided;
                            });
                          },
                          child: SvgPicture.asset(
                              "assets/images/vuesax_linear_eye-slash.svg"),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
