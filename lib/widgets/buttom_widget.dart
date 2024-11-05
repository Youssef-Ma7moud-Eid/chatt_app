import 'package:chatt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ButtomWidget extends StatelessWidget {
  const ButtomWidget({super.key, required this.text, this.color});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(9),
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: TextWidget(
        color: Colors.white,
        hinttext: text,
        bold: true,
        size: 20,
      ),
    );
  }
}
