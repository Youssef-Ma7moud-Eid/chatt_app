import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatt_app/widgets/Email_field.dart';
import 'package:chatt_app/widgets/email_reset_buttom.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});
  static String id = "ForgetPassword";

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text(
                'Forget pasword ?',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Image.asset(
                "assets/password.png",
                fit: BoxFit.cover,
                width: 500,
                height: 250,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(
                      '   Enter your registered email below to receive  ',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ' password reset instruction',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: EmailField(
                  obscureText: false,
                  hint: "Email",
                  onChanged: (data) {
                    email = data;
                  },
                  eye: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    await QuickAlert.show(
                      context: context,
                      type: QuickAlertType.info,
                      text: 'please check your email',
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    AwesomeDialog(
                      btnCancelOnPress: () {},
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Email invalid',
                      desc: e.toString(),
                    ).show();
                  }
                },
                child: EmailResetButtom(
                  text: 'Send reset password link',
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
