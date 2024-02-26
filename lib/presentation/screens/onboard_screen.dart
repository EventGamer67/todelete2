// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todelete2/domain/services/onboard_service.dart';
import 'package:todelete2/presentation/styles/fonts.dart';
import 'package:todelete2/presentation/widgets/mybutton_widget.dart';

class OnBoardWrapper extends StatelessWidget {
  const OnBoardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnBoardService(context),
      child: const OnBoardScreen(),
    );
  }
}

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    controller.value = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OnBoardService model = context.watch<OnBoardService>();
    model.anim = controller;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: controller,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(model.current.image),
                      const SizedBox(
                        height: 53,
                      ),
                      SizedBox(
                        width: 270,
                        child: Column(
                          children: [
                            Text(
                              model.current.tittle,
                              textAlign: TextAlign.center,
                              style: Fa.primary_700_24,
                            ),
                            Text(model.current.descr,
                                textAlign: TextAlign.center,
                                style: Fa.text4_400_16),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: MyButton(
                      enabled: true,
                      onTap: () {
                        model.skip(context);
                      },
                      filled: false,
                      text: "Skip",
                      height: 50,
                      width: double.infinity,
                    )),
                    const SizedBox(
                      width: 142,
                    ),
                    Expanded(
                        child: MyButton(
                      enabled: true,
                      onTap: () {
                        model.next();
                      },
                      filled: true,
                      text: "Next",
                      height: 50,
                      width: double.infinity,
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 99),
              ],
            )
          ],
        ),
      ),
    );
  }
}
