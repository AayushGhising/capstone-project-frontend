import 'package:flutter/material.dart';
import 'package:capstone_project/loading_screen.dart';
// ignore: unused_import
import 'package:capstone_project/signin_signup_screen.dart';
// ignore: unused_import
import 'package:capstone_project/home_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: LoadingScreen(),
      ),
    ),
  );
}
