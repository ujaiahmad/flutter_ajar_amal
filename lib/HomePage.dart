import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Column(
        children: [
          Text('Sign in as: '),
          Text(user.email!),
          ElevatedButton(
              onPressed: (() {
                FirebaseAuth.instance.signOut();
              }),
              child: Text('Log out'))
        ],
      ),
    );
  }
}
