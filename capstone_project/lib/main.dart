import 'package:flutter/material.dart';
import 'package:capstone_project/loading_screen.dart';
import 'package:capstone_project/signin_signup_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: LoadingScreen(),
      ),
    ),
  );
}
