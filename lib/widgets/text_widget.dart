import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.hinttext,
      required this.bold,
      this.size = 18,
      this.color});
  final String hinttext;
  final bool bold;
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      hinttext,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : null,
      ),
    );
  }
}
