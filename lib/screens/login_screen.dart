import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/padding_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: SizedBox(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your e-mail',
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      //Do something with the user input.
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  PaddingButton(
                    text: "Log-in",
                    colr: Colors.lightBlueAccent,
                    func: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final loginUserCredintial =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        setState(() {
                          showSpinner = false;
                        });
                        if (loginUserCredintial.user != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } on FirebaseAuthException catch (e) {
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('An error occured!'),
                            content: Text(e.message.toString()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Okay'),
                              ),
                            ],
                          ),
                        );
                      }
                      Navigator.pushNamed(context, ChatScreen.id);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
