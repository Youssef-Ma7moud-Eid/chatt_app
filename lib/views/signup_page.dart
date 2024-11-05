import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatt_app/views/login_page.dart';
import 'package:chatt_app/widgets/avatar_widget.dart';
import 'package:chatt_app/widgets/buttom_widget.dart';
import 'package:chatt_app/widgets/custom_appbar.dart';
import 'package:chatt_app/widgets/text_fields_with_icons.dart';
import 'package:chatt_app/widgets/text_form_field.dart';
import 'package:chatt_app/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  static String id = "Signup_page";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String username = "";
  String email = "";
  String password = "";
  bool isLoading = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Sign up'),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
        child: Form(
          autovalidateMode: autovalidateMode,
          key: formState,
          child: ListView(
            children: [
              const LogoWidget(),
              const SizedBox(height: 10),
              const TextWidget(
                hinttext: "Username",
                bold: true,
                size: 20,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                  hint: "Enter your username",
                  onChanged: (data) {
                    username = data;
                  }),
              TextFields(),
              const SizedBox(height: 10),
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
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            setState(() {
                              isLoading = false;
                            });
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Success',
                              desc: "Created account successful",
                              btnOkOnPress: () async {
                                await userCredential.user!
                                    .sendEmailVerification();
                                Navigator.pushReplacementNamed(
                                    context, LoginPage.id);
                              },
                            ).show();
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            String errorMessage;
                            switch (e.code) {
                              case 'weak-password':
                                errorMessage =
                                    'The password provided is too weak.';

                              case 'email-already-in-use':
                                errorMessage =
                                    'The account already exists for that email.';

                              default:
                                errorMessage = 'Please Enter valid email';
                            }
                            AwesomeDialog(
                              btnCancelOnPress: () {},
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Failed',
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
                              desc: "An unexpected error occurred.",
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
                        color: Colors.orange,
                        text: "Sign up",
                      ),
                    ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Have an account ? ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, LoginPage.id);
                    },
                    child: const TextWidget(
                      color: Colors.orange,
                      hinttext: "Login",
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
