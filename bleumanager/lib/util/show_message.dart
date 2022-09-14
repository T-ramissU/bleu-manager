import 'package:flutter/material.dart';

/// Show the [message] in a SnackBar located in the bottom of the screen
/// for [duration] seconds. By default it is 5 seconds.
/// Only works on Scaffold page
void showMessage(BuildContext context, String message, {int duration = 5}) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: duration),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}