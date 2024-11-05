import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 47,
      backgroundColor: Colors.brown[50],
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: CircleAvatar(
          radius: 28,
          child: Image.asset(
            "assets/logo.png",
          ),
        ),
      ),
    );
  }
}
