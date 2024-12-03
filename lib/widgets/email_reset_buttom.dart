import 'package:chatt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class EmailResetButtom extends StatelessWidget {
  const EmailResetButtom({super.key, required this.text, this.color});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
