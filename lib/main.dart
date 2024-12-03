import 'package:chatt_app/Intro_of_App/splash_screen.dart';
import 'package:chatt_app/views/forget_password.dart';
import 'package:chatt_app/views/home_page.dart';
import 'package:chatt_app/views/login_page.dart';
import 'package:chatt_app/views/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // String emailpattern =
  //     r"^(?=.{1,256})(?=.{1,64}@.{1,255}$)(?=.{1,64}@.+\..+)(?:(?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,}$";
  // RegExp regExp = new RegExp(emailpattern);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignupPage.id: (context) => SignupPage(),
        LoginPage.id: (context) => const LoginPage(),
        HomePage.id: (context) => HomePage(),
        ForgetPassword.id: (context) => ForgetPassword(),
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
