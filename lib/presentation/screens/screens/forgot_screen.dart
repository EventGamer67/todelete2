import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/providers/forget_service.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/widgets/mybutton_widget.dart';
import 'package:todelete2/presentation/widgets/mytextfield_widget.dart';
import 'package:todelete2/presentation/widgets/screen_header_widget.dart';

class ForgetWrapper extends StatelessWidget {
  const ForgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgetService(),
      child: const ForgetScreen(),
    );
  }
}

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  @override
  Widget build(BuildContext context) {
    ForgetService model = context.watch<ForgetService>();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                onChanged: () => Future.delayed(Duration.zero)
                    .then((value) => model.check()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 110,
                    ),
                    const ScreenHeader(
                        tittle: "Forgot Password",
                        desc: "Enter your email address"),
                    const SizedBox(
                      height: 56,
                    ),
                    Mytextfield(
                        tittle: "Email Address",
                        hint: "***********@mail.com",
                        validator: (text) {
                          return emailCorrect(text);
                        },
                        hidable: false,
                        onChanged: (text) => model.email = text),
                    const SizedBox(
                      height: 56,
                    ),
                    MyButton(
                        filled: true,
                        text: "Send OTP",
                        width: double.infinity,
                        height: 46,
                        enabled: model.correct,
                        onTap: () {
                          model.sendOTP(context);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remember password? Back to ",
                          style: Fa.gray2_400_14,
                        ),
                        GestureDetector(
                          onTap: () {
                            model.signIn(context);
                          },
                          child: Text("Sign in",
                              style:
                                  Fa.gray1_500_14.copyWith(color: Ca.primary)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
