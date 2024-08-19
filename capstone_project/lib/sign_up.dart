import 'dart:convert';

import 'package:capstone_project/components/my_button.dart';
import 'package:capstone_project/components/my_textfield.dart';
import 'package:capstone_project/components/square_tile.dart';
import 'package:capstone_project/sign_in.dart';
import 'package:capstone_project/verification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatelessWidget {
  SignUp({super.key});
//text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumnerController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //Sign user up method
  void signUserUp(BuildContext context) {
    //logic for signing up user here
    // validare the inputs
    //navigate to the verification page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Verification()),
    );
  }

  void postData(
    String email,
    String full_name,
    String password,
    String confirm_password,
    BuildContext context,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/register/'),
        body: {
          'email': email,
          'full_name': full_name,
          'password': password,
          'confirm_password': confirm_password,
        },
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(
          response.body.toString(),
        );
        print(data);
        print('Account Created Successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Verification()));
      } else {
        var data = jsonDecode(
          response.body.toString(),
        );
        print('failed');
        print(data);
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

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
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    //Sign Up text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Color.fromARGB(255, 111, 112, 231),
                              fontSize: 30,
                              fontFamily: 'Lato'),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          'assets/images/stethescope.png',
                          width: 70,
                          height: 70,
                        ),
                      ],
                    ),
                    //Create your new account text
                    const SizedBox(height: 15),
                    const Text(
                      'Create your new account',
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontFamily: 'Lato',
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30),
                    //Name textfield
                    MyTextfield(
                        controller: nameController,
                        hintText: 'Full Name',
                        obscureText: false),
                    //Email textfield
                    const SizedBox(height: 15),
                    MyTextfield(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false),
                    //Phone Number textfield
                    const SizedBox(height: 15),
                    MyTextfield(
                        controller: phoneNumnerController,
                        hintText: 'Phone Number',
                        obscureText: false),
                    //password textfield
                    const SizedBox(height: 15),
                    MyTextfield(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true),
                    //Confirm Password textfield
                    const SizedBox(height: 15),
                    MyTextfield(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true),
                    //forgot password
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Lato',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyButton(
                      onTap: () {
                        postData(
                          emailController.text.toString(),
                          nameController.text.toString(),
                          passwordController.text.toString(),
                          confirmPasswordController.text.toString(),
                          context,
                        );
                      },
                      label: 'Sign Up',
                    ),
                    //or continue with

                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or Continue With',
                              style: TextStyle(
                                color: Color.fromARGB(255, 111, 112, 231),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //google button
                        SquareTile(imagePath: 'assets/images/google.png'),

                        SizedBox(width: 15),
                        //facebook button
                        SquareTile(imagePath: 'assets/images/facebook.png'),

                        SizedBox(width: 15),
                        //apple button
                        SquareTile(imagePath: 'assets/images/apple.png')
                      ],
                    ),
                    const SizedBox(height: 20),
                    //dont have an account yet?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          },
                          child: const Text(
                            'Sign In here',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
