import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickSignUp;

  const LoginPage({super.key, required this.onClickSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Column(
        children: [
          TextFormField(
            controller: email,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextFormField(
            controller: password,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          ElevatedButton(
              onPressed: () {
                signIn();
              },
              child: Text('Log In')),
          // Text('Dont have account? Sign Up'),
          // ElevatedButton(
          //     onPressed: () {
          //       widget.onClickSignUp;
          //     },
          //     child: Text('Sign Ups')),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'Dont have account? ',
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickSignUp,
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                    text: 'Sign Up')
              ]))
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
