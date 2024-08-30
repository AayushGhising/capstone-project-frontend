import 'package:capstone_project/my_profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Widget upcomingReminder(
      String medicineNameAndDosage, String amount, String time) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 212, 212, 212),
              offset: Offset(0, 10),
              blurRadius: 10.0,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 5,
            bottom: 5,
            right: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/upcoming_reminder_pills.png'),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    medicineNameAndDosage,
                    style: const TextStyle(
                      fontFamily: 'lato',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Amount: $amount pills',
                    style: const TextStyle(
                      fontFamily: 'lato',
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/upcoming_reminder_clock.png'),
                      const SizedBox(width: 5),
                      Text(
                        time,
                        style: const TextStyle(
                          fontFamily: 'lato',
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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
                  bottom: 100,
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
                const SizedBox(height: 200),
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
                      child: SingleChildScrollView(
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
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(150, 0, 0, 0)),
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 255, 255, 255),
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
                                          color: Color.fromARGB(
                                              255, 212, 212, 212),
                                          offset: Offset(0, 10),
                                          blurRadius: 10.0,
                                          spreadRadius: -2,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          color: Color.fromARGB(
                                              255, 212, 212, 212),
                                          offset: Offset(0, 10),
                                          blurRadius: 10.0,
                                          spreadRadius: -2,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          color: Color.fromARGB(
                                              255, 212, 212, 212),
                                          offset: Offset(0, 10),
                                          blurRadius: 10.0,
                                          spreadRadius: -2,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          color: Color.fromARGB(
                                              255, 212, 212, 212),
                                          offset: Offset(0, 10),
                                          blurRadius: 10.0,
                                          spreadRadius: -2,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            ),

                            const SizedBox(height: 30),

                            // Upcoming Reminder Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "UPCOMING REMINDER",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Lato'),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "See All >",
                                    style: TextStyle(
                                        color: Color.fromARGB(200, 48, 48, 48),
                                        fontFamily: "lato"),
                                  ),
                                ),
                              ],
                            ),
                            //Reminder row 1 call
                            upcomingReminder('Tarzondone', '2', '2:00 pm'),
                            const SizedBox(height: 10),
                            upcomingReminder(
                                'Daridorexant, 10mg', '1', '2:05 pm'),
                            const SizedBox(height: 10),
                            upcomingReminder('Tarzondone', '2', '2:00 pm'),
                            const SizedBox(height: 10),
                            upcomingReminder(
                                'Daridorexant, 10mg', '1', '2:05 pm'),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Home Button
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              width: 60,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/home_nav.png'),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Home',
                                    style: TextStyle(
                                      fontFamily: 'lato',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Prescriptions Button
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              width: 85,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/images/prescription_nav.png'),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Prescriptions',
                                    style: TextStyle(
                                      fontFamily: 'lato',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 60),

                          // Notification Button
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              width: 85,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/images/notification_nav.png'),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Notifications',
                                    style: TextStyle(
                                      fontFamily: 'lato',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Account Button
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyProfile()));
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/profile_nav.png'),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Account',
                                    style: TextStyle(
                                      fontFamily: 'lato',
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 239, 239, 252),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Image.asset('assets/images/camera_nav.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //Camera button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   elevation: 10,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30),
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 239, 239, 252),
      //   child: Image.asset('assets/images/camera_nav.png'),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
