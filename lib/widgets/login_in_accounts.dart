import 'package:chatt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LoginInAccounts extends StatelessWidget {
  const LoginInAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Divider(
              thickness: 2,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          TextWidget(
            color: Colors.black.withOpacity(0.6),
            hinttext: " or login with ",
            bold: true,
            size: 17,
          ),
          SizedBox(
            width: 80,
            child: Divider(
              thickness: 2,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
