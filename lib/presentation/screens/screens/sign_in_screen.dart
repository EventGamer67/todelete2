import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/providers/sign_in_service.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/widgets/mybutton_widget.dart';
import 'package:todelete2/presentation/widgets/mytextfield_widget.dart';
import 'package:todelete2/presentation/widgets/screen_header_widget.dart';

class SignInWrapper extends StatelessWidget {
  const SignInWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInService(),
      child: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    SignInService model = context.watch<SignInService>();
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
                        tittle: "Welcome Back",
                        desc: "Fill in your email and password to continue"),
                    const SizedBox(
                      height: 20,
                    ),
                    Mytextfield(
                        tittle: "Email Address",
                        hint: "***********@mail.com",
                        hidable: false,
                        onChanged: (text) => model.email = text),
                    const SizedBox(
                      height: 24,
                    ),
                    Mytextfield(
                        tittle: "Password",
                        hint: "**********",
                        hidable: true,
                        onChanged: (text) => model.password = text),
                    const SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: 14,
                              height: 14,
                              child: Checkbox(
                                checkColor: Colors.white,
                                focusColor: Ca.primary,
                                activeColor: Ca.primary,
                                value: model.remember,
                                side: const BorderSide(
                                    color: Ca.gray2,
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignInside),
                                onChanged: (value) {
                                  model.swRemember();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Remember password",
                              style: Fa.gray2_500_12,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            model.forgot(context);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: Fa.gray2_500_12.copyWith(color: Ca.primary),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 187,
                    ),
                    MyButton(
                        filled: true,
                        text: "Log in",
                        width: double.infinity,
                        height: 46,
                        enabled: model.correct,
                        onTap: () {
                          model.logIn();
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: Fa.gray2_400_14,
                        ),
                        GestureDetector(
                          onTap: () {
                            model.signUp(context);
                          },
                          child: Text("Sign Up",
                              style:
                                  Fa.gray1_500_14.copyWith(color: Ca.primary)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "or log in using",
                        style: Fa.gray2_400_14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          model.googleIn();
                        },
                        child: SizedBox(
                            height: 16,
                            width: 16,
                            child: SvgPicture.asset(
                              "assets/images/Vector (13).svg",
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
