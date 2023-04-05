import 'package:flutter/material.dart';
import 'package:flutter_ajar_amal/loginPage.dart';
import 'package:flutter_ajar_amal/signUpPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickSignUp: toggle)
      : SignUpPage(onClickSignIn: toggle);
  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
