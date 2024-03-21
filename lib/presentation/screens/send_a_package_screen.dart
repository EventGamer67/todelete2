import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/providers/send_a_package_provider.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/styles/themes.dart';
import 'package:todelete2/presentation/widgets/myappbar_widget.dart';
import 'package:todelete2/presentation/widgets/mybutton_widget.dart';

class SendAPackageWrapper extends StatelessWidget {
  const SendAPackageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SendAPackageProvider(context),
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
              Destionations(provider: provider),
              AppendDestinationBlock(provider: provider),
              SizedBox(
                height: 13.h,
              ),
              PackageDetailsBlock(provider: provider),
              SizedBox(
                height: 39.h,
              ),
              DeliveryType(provider: provider),
              SizedBox(
                height: 39.h,
              ),
              MyButton(
                  filled: true,
                  text: "Next",
                  width: double.infinity,
                  height: 46,
                  enabled: true,
                  onTap: () {
                    provider.goToReceipt(context);
                  }),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      )),
    );
  }
}

class DeliveryType extends StatelessWidget {
  final SendAPackageProvider provider;
  const DeliveryType({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Select delivery type",
            style: Fa.text4_500_14,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          height: 75,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 5, color: Colors.black.withOpacity(0.15))
                  ], color: Ca.primary, borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/clock.svg"),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Instant delivery",
                          style: Fa.text4_500_14.copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 24.w,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.15))
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/asd.svg",
                          color: Ca.gray2,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Scheduled delivery",
                          style: Fa.text4_500_14.copyWith(color: Ca.gray2),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PackageDetailsBlock extends StatelessWidget {
  const PackageDetailsBlock({super.key, required this.provider});
  final SendAPackageProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Package Details",
            style: Fa.text4_500_14,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        MyTextField(
          onChanged: (value) {
            provider.packages[0].package.packageItem = value;
          },
          hint: "package items",
        ),
        SizedBox(
          height: 8.h,
        ),
        MyTextField(
          onChanged: (value) {
            provider.packages[0].package.weight = value;
          },
          hint: "Weight of item(kg)",
        ),
        SizedBox(
          height: 8.h,
        ),
        MyTextField(
          onChanged: (value) {
            provider.packages[0].package.weight = value;
          },
          hint: "Worth of Items",
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}

class AppendDestinationBlock extends StatelessWidget {
  const AppendDestinationBlock({
    super.key,
    required this.provider,
  });

  final SendAPackageProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        provider.appendNewDestination();
      },
      child: Row(
        children: [
          SvgPicture.asset("assets/images/add-square.svg"),
          SizedBox(width: 6.w),
          Text(
            "Add destination",
            style: Fa.gray2_400_12,
          ),
        ],
      ),
    );
  }
}

class Destionations extends StatelessWidget {
  const Destionations({
    super.key,
    required this.provider,
  });

  final SendAPackageProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
        children:
            List.generate(provider.packages[0].destinations.length, (index) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DestinationDetailsBlock(provider: provider, index: index),
          index != provider.packages[0].destinations.length - 1
              ? SizedBox(
                  height: 24.h,
                )
              : SizedBox(
                  height: 14.h,
                )
        ],
      );
    }));
  }
}

class DestinationDetailsBlock extends StatelessWidget {
  const DestinationDetailsBlock(
      {super.key, required this.provider, required this.index});
  final SendAPackageProvider provider;
  final int index;
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
        MyTextField(
            onChanged: (value) {
              provider.packages[0].destinations[index].address = value;
            },
            hint: "Address"),
        SizedBox(
          height: 4.h,
        ),
        MyTextField(
            onChanged: (value) {
              provider.packages[0].destinations[index].stateCounty = value;
            },
            hint: "State,Country"),
        SizedBox(
          height: 4.h,
        ),
        MyTextField(
            onChanged: (value) {
              provider.packages[0].destinations[index].phone = value;
            },
            hint: "Phone number"),
        SizedBox(
          height: 4.h,
        ),
        MyTextField(
            onChanged: (value) {
              provider.packages[0].destinations[index].others = value;
            },
            hint: "Others"),
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
          onChanged: (value) {
            provider.packages[0].origin.address = value;
          },
          controller: provider.address,
          hint: "Address",
        ),
        SizedBox(
          height: 5.h,
        ),
        MyTextField(
          controller: provider.country,
          onChanged: (value) {
            provider.packages[0].origin.stateCounty = value;
          },
          hint: "State,Country",
        ),
        SizedBox(
          height: 5.h,
        ),
        MyTextField(
          onChanged: (value) {
            provider.packages[0].origin.phone = value;
          },
          hint: "Phone number",
        ),
        SizedBox(
          height: 5.h,
        ),
        MyTextField(
          onChanged: (value) {
            provider.packages[0].origin.others = value;
          },
          hint: "Others",
        )
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final Function onChanged;
  final String hint;
  final TextEditingController? controller;
  const MyTextField(
      {super.key,
      required this.onChanged,
      required this.hint,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevetedBlank(
        height: 32.h,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8.w, 0.h, 8.h, 0.w),
          child: Center(
            child: TextField(
              controller: controller,
              style: Fa.text4_400_12,
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
