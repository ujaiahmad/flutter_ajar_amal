import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ajar_amal/utils.dart';

import 'main.dart';

class SignUpPage extends StatefulWidget {
  final Function() onClickSignIn;
  const SignUpPage({super.key, required this.onClickSignIn});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
      appBar: AppBar(title: Text('Sign Up')),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(hintText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(hintText: 'Password'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 6
                  ? 'Enter min. 6 characters'
                  : null,
            ),
            ElevatedButton(
                onPressed: () {
                  SignUp();
                },
                child: Text('Sign Up')),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: 'Already have an account? ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickSignIn,
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      text: 'log in')
                ])),
            // Text('Already have an account? Log in'),
            // ElevatedButton(
            //     onPressed: () {
            //       widget.onClickSignIn;
            //     },
            //     child: Text('Log in'))
          ],
        ),
      ),
    );
  }

  Future SignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return; //if not valid return nothing
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
