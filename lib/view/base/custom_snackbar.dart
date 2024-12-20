import 'package:flutter/material.dart';

import '../../main.dart';


void showCustomSnackBar(
    String message,
    BuildContext context, bool isError) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 16.0, // Adjust font size as needed
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.fixed, // Use fixed to make it full width
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
}

