import 'package:flutter/material.dart';

class PaddingButton extends StatelessWidget {
  final String text;
  final Color colr;
  final Function() func;

  const PaddingButton(
      {super.key, required this.text, required this.colr, required this.func});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Material(
        elevation: 5.0,
        color: colr,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: func,
          //Go to login screen.
          // Navigator.pushNamed(context, toID);

          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
