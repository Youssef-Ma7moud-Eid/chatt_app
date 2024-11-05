import 'package:chatt_app/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget(
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
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
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
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
