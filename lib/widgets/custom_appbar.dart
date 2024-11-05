import 'package:chatt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: TextWidget(
        hinttext: title,
        bold: true,
        size: 25,
        color: Colors.orange,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
