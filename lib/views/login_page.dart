import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatt_app/views/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatt_app/views/signup_page.dart';
import 'package:chatt_app/widgets/avatar_widget.dart';
import 'package:chatt_app/widgets/buttom_widget.dart';
import 'package:chatt_app/widgets/custom_appbar.dart';
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
                              btnCancelOnPress: () {
                                setState(() {});
                              },
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
              Padding(
                padding: const EdgeInsets.all(9),
                child: MaterialButton(
                  textColor: Colors.white,
                  color: Colors.red[700],
                  height: 55,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () async {
                    signInWithGoogle();

                    AwesomeDialog(
                            btnOkOnPress: () {
                              Navigator.pushReplacementNamed(
                                  context, HomePage.id);
                            },
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Sucess',
                            desc: "login succsseful")
                        .show();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(
                        color: Colors.white,
                        hinttext: " Login with Google   ",
                        bold: true,
                        size: 20,
                      ),
                      Image.asset(
                        'assets/4.png',
                        height: 29,
                      ),
                    ],
                  ),
                ),
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

    await Future.delayed(const Duration(seconds: 2)); // Check every 5 seconds
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
