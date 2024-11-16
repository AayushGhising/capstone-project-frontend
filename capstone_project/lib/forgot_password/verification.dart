import 'dart:async';

import 'package:capstone_project/components/my_button.dart';
import 'package:capstone_project/sign_in.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Verification extends StatefulWidget {
  const Verification({super.key});
  @override
  State<Verification> createState() {
    return _VerificationState();
  }
}

class _VerificationState extends State<Verification> {
  int resendTime = 60;
  late Timer countdownTimer;

  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (resendTime > 0) {
          resendTime--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    countdownTimer.cancel();
  }

  void resendCode() {
    print('Resending code...');
    setState(() {
      resendTime = 60;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset('assets/images/verify.png',
                    height: 400, width: 400, fit: BoxFit.contain),
              ),
              const Text(
                'Verify your Email',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter the 4 digit code sent to your email.',
                style: TextStyle(
                  color: Color.fromARGB(255, 112, 105, 105),
                  fontFamily: 'Lato',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) =>
                      myInputBox(context, controllers[index], index == 3),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Did not recieve a code yet?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 112, 105, 321),
                        fontFamily: 'Lato',
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (resendTime > 0)
                      Text(
                        'You can resend code after $resendTime second(s)',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 112, 105, 105),
                          fontFamily: 'Lato',
                          fontSize: 16,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: resendCode,
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(
                            color: Color.fromARGB(255, 111, 112, 231),
                            fontFamily: 'Lato',
                            fontSize: 24,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: IntrinsicWidth(
                  child: MyButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 125),
                                        Image.asset(
                                          'assets/images/tick.png',
                                          height: 35,
                                          width: 35,
                                        ),
                                        const SizedBox(width: 80),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignIn()),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/images/cross.png',
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    const Text(
                                      'Verified',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Lato',
                                          fontSize: 28),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Yahoo!  You have successfully verified the account',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 108, 84, 84),
                                          fontFamily: 'Lato',
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      label: 'Confirm'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget myInputBox(
    BuildContext context, TextEditingController controller, bool isLast) {
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
        if (value.isNotEmpty && !isLast) {
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
}
