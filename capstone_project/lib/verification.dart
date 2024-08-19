import 'package:capstone_project/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Verification extends StatelessWidget {
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();

  Verification({super.key});

  void postData(
    String txt1,
    String txt2,
    String txt3,
    String txt4,
    BuildContext context,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/verify-email/'),
        body: {
          'otp': txt1 + txt2 + txt3 + txt4,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(
          response.body.toString(),
        );
        print(data);
        print('Verified Successfully');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/verify.png',
                    height: 400, width: 400),
              ),
              const Text(
                'Verify your Email',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please enter the 4 digit code sent to your email.',
                style: TextStyle(
                  color: Color.fromARGB(255, 112, 105, 105),
                  fontFamily: 'Lato',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myInputBox(context, txt1),
                  myInputBox(context, txt2),
                  myInputBox(context, txt3),
                  myInputBox(context, txt4),
                ],
              ),
              const SizedBox(height: 50),
              const Center(
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      color: Color.fromARGB(255, 111, 112, 231),
                      fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                  onTap: () {
                    postData(
                      txt1.text.toString(),
                      txt2.text.toString(),
                      txt3.text.toString(),
                      txt4.text.toString(),
                      context,
                    );
                  },
                  label: 'Confirm')
            ],
          ),
        ),
      ),
    );
  }
}

Widget myInputBox(BuildContext context, TextEditingController controller) {
  return Container(
    height: 70,
    width: 60,
    decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        )),
    child: TextField(
      controller: controller,
      maxLength: 1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 40),
      decoration: const InputDecoration(
        counterText: '',
      ),
      onChanged: (value) {
        FocusScope.of(context).nextFocus();
      },
    ),
  );
}
