import 'package:capstone_project/components/my_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 242, 247, 250),
        child: Stack(
          children: [
            Container(
              height: 400,
              color: const Color.fromARGB(255, 180, 177, 243),
              child: const Padding(
                padding: EdgeInsets.only(
                  bottom: 80,
                  left: 20,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/luffy.jpg'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome!",
                          style: TextStyle(
                            color: Color.fromARGB(255, 48, 48, 48),
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          "Monkey D. Luffy",
                          style: TextStyle(
                            color: Color.fromARGB(255, 48, 48, 48),
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 220),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 242, 247, 250),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 186, 186, 186),
                          offset: Offset(0, -2),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        right: 20,
                        left: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //search bar
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                            ),
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 212, 212, 212),
                                    offset: Offset(0, 10),
                                    blurRadius: 10.0,
                                    spreadRadius: -2,
                                  )
                                ],
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Categories Section
                          const Text(
                            "CATEGORIES",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Lato'),
                          ),
                          const SizedBox(height: 10),

                          // Upload Prescription and Prescription Folder Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Upload Prescription Button
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 110,
                                  width: 175,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 212, 212, 212),
                                        offset: Offset(0, 10),
                                        blurRadius: 10.0,
                                        spreadRadius: -2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/upload_prescription.png'),
                                      const Text(
                                        'UPLOAD',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      const Text(
                                        'PRESCRIPTION',
                                        style: TextStyle(fontFamily: 'Lato'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Presctiption Floder Button
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 110,
                                  width: 175,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 212, 212, 212),
                                        offset: Offset(0, 10),
                                        blurRadius: 10.0,
                                        spreadRadius: -2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/prescription_folder.png'),
                                      const Text(
                                        'PRESCRIPTION',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      const Text(
                                        'FLODER',
                                        style: TextStyle(fontFamily: 'Lato'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Medication Reminder and Medication Chart Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Upload Prescription Button
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 110,
                                  width: 175,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 212, 212, 212),
                                        offset: Offset(0, 10),
                                        blurRadius: 10.0,
                                        spreadRadius: -2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/medication_reminder.png'),
                                      const Text(
                                        'MEDICATION',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      const Text(
                                        'REMINDER',
                                        style: TextStyle(fontFamily: 'Lato'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Presctiption Floder Button
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 110,
                                  width: 175,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 212, 212, 212),
                                        offset: Offset(0, 10),
                                        blurRadius: 10.0,
                                        spreadRadius: -2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/medication_chart.png'),
                                      const Text(
                                        'MEDICATION',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      const Text(
                                        'CHART',
                                        style: TextStyle(fontFamily: 'Lato'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
