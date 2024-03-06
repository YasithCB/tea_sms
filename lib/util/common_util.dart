import 'package:flutter/material.dart';

void showSnackBar(context, message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 85 * message.toString().length),
    ),
  );
}

