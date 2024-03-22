import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/providers/reset_service.dart';
import 'package:todelete2/presentation/widgets/mybutton_widget.dart';
import 'package:todelete2/presentation/widgets/mytextfield_widget.dart';
import 'package:todelete2/presentation/widgets/screen_header_widget.dart';

class ResetWrapper extends StatelessWidget {
  const ResetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ResetService(), child: const ResetScreen());
  }
}

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  @override
  Widget build(BuildContext context) {
    ResetService model = context.watch<ResetService>();
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
                        tittle: "New Password", desc: "Enter new password"),
                    const SizedBox(
                      height: 70,
                    ),
                    Mytextfield(
                        tittle: "Password",
                        hint: "**********",
                        hidable: true,
                        onChanged: (text) => model.password = text),
                    const SizedBox(
                      height: 24,
                    ),
                    Mytextfield(
                        tittle: "Confirm Password",
                        hint: "**********",
                        hidable: true,
                        onChanged: (text) => model.confPassword = text),
                    const SizedBox(
                      height: 71,
                    ),
                    MyButton(
                        filled: true,
                        text: "Log in",
                        width: double.infinity,
                        height: 46,
                        enabled: model.correct,
                        onTap: () {
                          model.setPassword(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
