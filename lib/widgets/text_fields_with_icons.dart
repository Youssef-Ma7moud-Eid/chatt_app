import 'package:chatt_app/widgets/text_form_field.dart';
import 'package:chatt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  TextFields({super.key, this.forget = false});

  static String email = "";
  static String password = "";
  final bool forget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        const Align(
            alignment: Alignment.topLeft,
            child: TextWidget(hinttext: "Email", bold: true, size: 20)),
        const SizedBox(height: 12),
        TextFormFieldWidget(
          onChanged: (data) {
            email = data;
          },
          hint: "Enter your email",
        ),
        const SizedBox(height: 15),
        const Align(
            alignment: Alignment.topLeft,
            child: TextWidget(hinttext: "Password", bold: true, size: 20)),
        const SizedBox(height: 12),
        TextFormFieldWidget(
          obscureText: true,
          hint: "Enter your password",
          onChanged: (data) {
            password = data;
          },
          eye: true,
        ),
        const SizedBox(height: 12),
        forget == true
            ? InkWell(
                onTap: () {},
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextWidget(
                    color: Colors.black.withOpacity(0.5),
                    hinttext: "Forget password?",
                    bold: true,
                    size: 17,
                  ),
                ),
              )
            : const Text(''),
      ],
    );
  }
}
