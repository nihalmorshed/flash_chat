import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/padding_button.dart';
import 'package:flash_chat/screens/reg_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(
        seconds: 5,
      ),
      vsync: this,
    );
    animation = ColorTween(
      begin: Colors.white,
      end: Colors.red,
    ).animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(
                        milliseconds: 70,
                      ),
                    )
                  ],
                  repeatForever: true,
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            PaddingButton(
              text: 'Log-In',
              colr: Colors.lightBlueAccent,
              func: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            PaddingButton(
              text: 'Register',
              colr: Colors.blueAccent,
              func: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
