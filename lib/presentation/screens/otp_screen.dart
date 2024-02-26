import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/services/otp_service.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/widgets/mybutton_widget.dart';
import 'package:todelete2/presentation/widgets/screen_header_widget.dart';
import 'package:pinput/pinput.dart';

class OTPWrapper extends StatelessWidget {
  const OTPWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OTPService(),
      child: const OTPScreen(),
    );
  }
}

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    OTPService model = context.watch<OTPService>();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 113,
                  ),
                  const ScreenHeader(
                      tittle: "OTP Verification",
                      desc: "Enter the 6 digit numbers sent to your email"),
                  const SizedBox(
                    height: 52,
                  ),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 6,
                    onChanged: (value) {
                      model.setCode(value);
                    },
                    errorTextStyle: const TextStyle(fontSize: 0),
                    onCompleted: (value) => model.check(),
                    validator: (value) {
                      if (value!.length == 6) {
                        model.check();
                        return model.correct ? null : "";
                      } else {
                        return "";
                      }
                    },
                    errorPinTheme: PinTheme(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Ca.error)),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Ca.gray2)),
                    ),
                    followingPinTheme: PinTheme(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Ca.gray2)),
                    ),
                    defaultPinTheme: PinTheme(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    model.correct ? Ca.success : Ca.primary))),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "If you didn’t receive code, ",
                        style: Fa.gray2_400_14,
                      ),
                      GestureDetector(
                        onTap: () {
                          model.reset(context);
                        },
                        child: Text("resend",
                            style: Fa.gray1_500_14.copyWith(color: Ca.primary)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 84,
                  ),
                  MyButton(
                      filled: true,
                      text: "Set New Password",
                      width: double.infinity,
                      height: 46,
                      enabled: model.correct,
                      onTap: () {
                        model.reset(context);
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
