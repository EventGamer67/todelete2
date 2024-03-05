import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todelete2/domain/services/send_a_package_provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'package:todelete2/presentation/widgets/myappbar_widget.dart';

class SendAPackageWrapper extends StatelessWidget {
  const SendAPackageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SendAPackageProvider(),
      child: const SendAPackageScreen(),
    );
  }
}

class SendAPackageScreen extends StatefulWidget {
  const SendAPackageScreen({super.key});

  @override
  State<SendAPackageScreen> createState() => _SendAPackageScreenState();
}

class _SendAPackageScreenState extends State<SendAPackageScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    SendAPackageProvider provider = context.watch<SendAPackageProvider>();
    return Scaffold(
      backgroundColor: themeProvider.isDark ? Ca.prishade1 : Colors.white,
      appBar: const MyAppBar(
        tittle: "Send a package",
        back: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 43.h,
              ),
              OriginDetails(provider: provider),
              SizedBox(
                height: 39.h,
              ),
              Column(
                  children: List.generate(
                      provider.packages[0].destinations.length, (index) {
                return Column(
                  children: [
                    DestinationDetailsBlock(provider: provider),
                    index != provider.packages[0].destinations.length - 1
                        ? const SizedBox(
                            height: 24,
                          )
                        : const SizedBox(
                            height: 14,
                          )
                  ],
                );
              })),
              GestureDetector(
                onTap: () {
                  provider.appendNewDestination();
                },
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/add-square.svg"),
                    const SizedBox(width: 6),
                    Text(
                      "Add destination",
                      style: Fa.gray2_400_12,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class DestinationDetailsBlock extends StatelessWidget {
  const DestinationDetailsBlock({super.key, required this.provider});
  final SendAPackageProvider provider;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/images/des.svg",
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              "Destination Details",
              style: Fa.text4_500_14,
            ),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        MyTextField(onChanged: () {}, hint: "Address"),
        SizedBox(
          height: 4.h,
        ),
        MyTextField(onChanged: () {}, hint: "State,Country"),
        SizedBox(
          height: 4.h,
        ),
        MyTextField(onChanged: () {}, hint: "Phone number"),
        SizedBox(
          height: 4.h,
        ),
        MyTextField(onChanged: () {}, hint: "Others"),
      ],
    );
  }
}

class OriginDetails extends StatelessWidget {
  const OriginDetails({
    super.key,
    required this.provider,
  });

  final SendAPackageProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/images/Vector.svg",
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              "Origin Details",
              style: Fa.text4_500_14,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        MyTextField(
          onChanged: (value) {},
          hint: "Address",
        ),
        SizedBox(
          height: 5.h,
        ),
        MyTextField(
          onChanged: (value) {},
          hint: "State,Country",
        ),
        SizedBox(
          height: 5.h,
        ),
        MyTextField(
          onChanged: (value) {},
          hint: "Phone number",
        ),
        SizedBox(
          height: 5.h,
        ),
        MyTextField(
          onChanged: (value) {},
          hint: "Others",
        )
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final Function onChanged;
  final String hint;
  const MyTextField({
    super.key,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return ElevetedBlank(
        height: 32.h,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8.w, 0.h, 8.h, 0.w),
          child: Center(
            child: TextField(
              onChanged: (value) => onChanged(value),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration.collapsed(
                  hintText: hint, hintStyle: Fa.gray1_400_12),
            ),
          ),
        ));
  }
}

class ElevetedBlank extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  const ElevetedBlank(
      {super.key,
      required this.child,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
          color: themeProvider.isDark ? Ca.prishade2 : Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.15))
          ]),
      child: child,
    );
  }
}
