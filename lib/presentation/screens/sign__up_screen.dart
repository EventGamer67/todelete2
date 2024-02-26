import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/services/sign_up_service.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/widgets/mybutton_widget.dart';
import 'package:todelete2/presentation/widgets/mytextfield_widget.dart';
import 'package:todelete2/presentation/widgets/screen_header_widget.dart';

class SignUpWrapper extends StatelessWidget {
  const SignUpWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpService(),
      child: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    SignUpService model = context.watch<SignUpService>();
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
                      height: 33,
                    ),
                    const ScreenHeader(
                        tittle: "Create an account",
                        desc: "Complete the sign up process to get started"),
                    const SizedBox(
                      height: 33,
                    ),
                    Mytextfield(
                        tittle: "Full name",
                        hint: "Ivanov Ivan",
                        hidable: false,
                        onChanged: (text) => model.fio = text),
                    const SizedBox(
                      height: 24,
                    ),
                    Mytextfield(
                        tittle: "Phone Number",
                        hint: "+7(999)999-99-99",
                        hidable: false,
                        onChanged: (text) => model.phone = text),
                    const SizedBox(
                      height: 24,
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
                        hidable: false,
                        onChanged: (text) => model.password = text),
                    const SizedBox(
                      height: 24,
                    ),
                    Mytextfield(
                        tittle: "Confirm Password",
                        hint: "**********",
                        hidable: false,
                        onChanged: (text) => model.confpassword = text),
                    const SizedBox(
                      height: 37,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 14,
                          height: 14,
                          child: Checkbox(
                            checkColor: Colors.white,
                            focusColor: Ca.primary,
                            activeColor: Ca.primary,
                            value: model.terms,
                            side: const BorderSide(
                                color: Ca.primary,
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignInside),
                            onChanged: (value) {
                              model.swTerms();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        SizedBox(
                          width: 270,
                          child: GestureDetector(
                            onTap: () {
                              model.openTerms(context);
                            },
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          "By ticking this box, you agree to our",
                                      style: Fa.gray2_500_12.copyWith(
                                          fontWeight: FontWeight.w400)),
                                  TextSpan(
                                      text:
                                          "Terms and conditions and private policy",
                                      style: Fa.yellow_400_12),
                                ])),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    MyButton(
                        filled: true,
                        text: "Sign Up",
                        width: double.infinity,
                        height: 46,
                        enabled: model.correct,
                        onTap: () {
                          model.signUp();
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
                            model.signIn(context);
                          },
                          child: Text("Sign in",
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
                        "or sign in using",
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
