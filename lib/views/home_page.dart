import 'package:chatt_app/views/login_page.dart';
import 'package:chatt_app/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = "Home_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const TextWidget(
          size: 23,
          hinttext: "Home",
          bold: true,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, LoginPage.id);
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
