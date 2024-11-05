import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  const IconWidget({super.key, required this.obscureText});
  final bool obscureText;
  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.obscureText == false
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off);
  }
}
