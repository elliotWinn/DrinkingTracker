
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double radius;
  final VoidCallback onPressed;
  final String text;


  const CircularButton({required this.radius, required this.onPressed, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(radius),
        // backgroundColor: const Color.fromRGBO(255, 255, 255, 0.1),
        // foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        // shadowColor: const Color.fromRGBO(255, 255, 255, 1),
        // surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: radius),
      ),
    );
  }
}