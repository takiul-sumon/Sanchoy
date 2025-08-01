import 'package:flutter/material.dart';

void showShackBarMessenger(
  BuildContext context,
  String message, [
  bool isError = false,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(backgroundColor: isError ? Colors.red :null),
      ),
    ),
  );
}
