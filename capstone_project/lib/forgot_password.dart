import 'package:flutter/material.dart';
import 'package:capstone_project/components/my_textfield.dart';
import 'package:capstone_project/components/my_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() {
    return _ForgotPasswordState();
  }
}

final emailController = TextEditingController();

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              Center(
                child: Image.asset(
                  'assets/images/forgotPassword.png',
                  height: 340,
                  width: 340,
                  fit: BoxFit.contain,
                ),
              ),
              //Forgot Passowrd?
              const SizedBox(height: 30),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color.fromARGB(255, 48, 48, 48),
                  fontFamily: 'Lato',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Enter email
              const SizedBox(height: 20),
              const Text(
                'Enter your email address to recieve a password reset link.',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                    color: Color.fromARGB(255, 135, 135, 153)),
              ),
              //Email text field
              const SizedBox(height: 30),
              MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false),
              //Button
              const SizedBox(height: 35),
              IntrinsicWidth(
                child: MyButton(onPressed: () {}, label: 'Confirm Mail'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
