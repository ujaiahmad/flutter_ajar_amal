import 'package:flutter/material.dart';

// final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class Utils {
  static showSnackBar(String? text) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
