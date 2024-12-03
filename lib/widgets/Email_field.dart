import 'package:chatt_app/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  EmailField(
      {super.key,
      required this.hint,
      this.eye = false,
      this.obscureText = false,
      this.onChanged});
  final String hint;
  bool eye;
  final void Function(String)? onChanged;
  bool obscureText;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        obscureText: widget.obscureText,
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          } else {
            return null;
          }
        },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: widget.eye == true
              ? GestureDetector(
                  onTap: () {
                    if (widget.obscureText == true) {
                      widget.obscureText = false;
                    } else {
                      widget.obscureText = true;
                    }
                    setState(() {});
                  },
                  child: IconWidget(
                    obscureText: widget.obscureText,
                  ))
              : null,
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
