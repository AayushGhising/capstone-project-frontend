import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/SignBack.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 10.0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          const Positioned(
            top: 90.0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Color.fromARGB(255, 111, 112, 231),
                    fontSize: 35,
                    fontFamily: 'Lato'),
              ),
            ),
          ),
          const Text(
            'Create your New Account',
            style: TextStyle(
                color: Color.fromARGB(255, 48, 48, 48),
                fontSize: 20,
                fontFamily: 'Lato'),
          ),
          const Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
