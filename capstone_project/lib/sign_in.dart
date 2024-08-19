import 'package:capstone_project/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/components/my_textfield.dart';
import 'package:capstone_project/components/my_button.dart';
import 'package:capstone_project/components/square_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:capstone_project/home_page.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void postData(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login/'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(
          response.body.toString(),
        );
        print(data);
        print('Logged In Successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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

  //sign user in method
  void signUserIn() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logBack.png'),
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
                    Image.asset(
                      'assets/images/logoOnly.png',
                      width: 200,
                      height: 200,
                    ),

                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Color.fromARGB(255, 111, 112, 231),
                        fontSize: 35,
                        fontFamily: 'Lato',
                      ),
                    ),

                    const Text(
                      'Log In to your account',
                      style: TextStyle(
                        color: Color.fromARGB(255, 44, 40, 40),
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                    ),
                    const SizedBox(height: 30),

                    //Username TextFiled
                    MyTextfield(
                      controller: emailController,
                      obscureText: false,
                      hintText: 'Email',
                    ),

                    const SizedBox(height: 15),
                    //Password TextField
                    MyTextfield(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    //forgot password
                    const Padding(
                      padding: EdgeInsets.all(25.0),
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
                    //sign in button
                    MyButton(
                      onTap: () {
                        postData(
                          emailController.text.toString(),
                          passwordController.text.toString(),
                          context,
                        );
                      },
                      label: 'Sign In',
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
                        const Text("Don't have an account yet?"),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: const Text(
                            'Register Now',
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
          ),
        ],
      ),
    );
  }
}
