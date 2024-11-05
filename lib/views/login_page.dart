import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatt_app/views/home_page.dart';

import 'package:chatt_app/views/signup_page.dart';
import 'package:chatt_app/widgets/accounts_login_widget.dart';
import 'package:chatt_app/widgets/avatar_widget.dart';

import 'package:chatt_app/widgets/buttom_widget.dart';
import 'package:chatt_app/widgets/custom_appbar.dart';
import 'package:chatt_app/widgets/login_in_accounts.dart';
import 'package:chatt_app/widgets/text_fields_with_icons.dart';

import 'package:chatt_app/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = "Login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool isLoading = false;
  // dynamic state ;
  String errorMessage = "";
  GlobalKey<FormState> formState = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Login'),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
        child: Form(
          autovalidateMode: autovalidateMode,
          key: formState,
          child: ListView(
            children: [
              const LogoWidget(),
              TextFields(
                forget: true,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () async {
                        email = TextFields.email;
                        password = TextFields.password;
                        setState(() {
                          isLoading = true;
                        });
                        if (formState.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            AwesomeDialog(
                              btnCancelOnPress: () {},
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'verify your email',
                            ).show();
                            if (FirebaseAuth
                                .instance.currentUser!.emailVerified) {
                              Navigator.pushReplacementNamed(
                                  context, HomePage.id);
                            } else {
                              await checkEmailVerification(
                                  FirebaseAuth.instance.currentUser!, context);
                            }
                          } on FirebaseAuthException catch (e) {
                            switch (e.code) {
                              case 'user-not-found':
                                errorMessage = 'No user found for that email.';

                              case 'wrong-password':
                                errorMessage =
                                    'Wrong password provided for that user.';

                              default:
                                errorMessage =
                                    'An error occurred. Please try again.';
                            }
                            setState(() {
                              isLoading = false;
                            });
                            AwesomeDialog(
                              btnCancelOnPress: () {},
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Login Failed',
                              desc: errorMessage,
                            ).show();
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            AwesomeDialog(
                              btnCancelOnPress: () {},
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: errorMessage,
                            ).show();
                          }
                        } else {
                          setState(() {
                            isLoading = false;
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      child: const ButtomWidget(
                        color: Colors.blue,
                        text: "Login",
                      ),
                    ),
              const SizedBox(height: 15),
              const LoginInAccounts(),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CardAccount(child: Icon(Icons.facebook, size: 55)),
                  CardAccount(
                    child: Image.asset("assets/4.png", height: 50),
                  ),
                  const CardAccount(child: Icon(Icons.apple, size: 55)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ? ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, SignupPage.id);
                    },
                    child: const TextWidget(
                      color: Colors.blue,
                      hinttext: "Register",
                      bold: true,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> checkEmailVerification(User user, BuildContext context) async {
  while (true) {
    await user.reload(); // Reload user data
    user = FirebaseAuth.instance.currentUser!; // Refresh the user object

    if (user!.emailVerified) {
      print("Email is verified.");
      Navigator.pushReplacementNamed(context, HomePage.id);
      break; // Exit the loop
    }

    await Future.delayed(const Duration(seconds: 5)); // Check every 5 seconds
  }
}
