import 'package:flutter/material.dart';

class DummySignupScreen extends StatelessWidget {
  const DummySignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('Sign Up Screen')],
          ),
        ),
      ),
    );
  }
}
