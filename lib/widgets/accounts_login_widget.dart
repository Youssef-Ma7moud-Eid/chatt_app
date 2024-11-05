import 'package:flutter/material.dart';

class CardAccount extends StatelessWidget {
  const CardAccount({super.key, required this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
