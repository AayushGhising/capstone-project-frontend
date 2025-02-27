import 'package:capstone_project/medication_reminder/add_medication.dart';
import 'package:capstone_project/medication_reminder/reminder.dart';
import 'dart:convert';
import 'package:capstone_project/my_profile/my_profile.dart';
import 'package:capstone_project/prescription_folder/prescription.dart';
import 'package:capstone_project/scan/scan_image.dart';
import 'package:capstone_project/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:capstone_project/medication_reminder/reminder.dart';

// Storing user data in flutter secure storage
Future<void> storeUserData(String fullName, String profilePic) async {
  final storage = FlutterSecureStorage();
  await storage.write(key: 'full_name', value: fullName);
  await storage.write(key: 'profile_pic', value: profilePic);
}

// Fetching Stored Tokens From Flutter Secure Storage
Future<String?> getUserFullName() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'full_name');
}

Future<String?> getUserProfilePic() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'profile_pic');
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<UpcomingReminders> upcomingReminders = [];
  List<UpcomingRemindersTimes> upcomingRemindersTimes = [];
  // Fetching tokens form sign_in file and putting it in a varible
  final storage = FlutterSecureStorage();
  Future<String?> accessToken = getSignInAccessToken();
  Future<String?> refreshToken = getSignInRefreshToken();

  // Stating varibles to hold user data
  String? profile_pic;
  String? full_name;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData(); // Fetch profile picture or update state
  }

//Fetching upcoming reminders from the backend using API
  Future<List<UpcomingReminders>> getUpcomingReminders() async {
    final access_token = await accessToken;
    final refresh_token = await refreshToken;
    try {
      final response = await http.get(
          Uri.parse('http://10.0.2.2:8000/api/reminders/'),
          headers: {'Authorization': 'Bearer $access_token'});
      var data = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        upcomingRemindersTimes = data
            .map<UpcomingRemindersTimes>((item) => UpcomingRemindersTimes(
                  time: item['time'],
                  dosage: item['dosage'],
                ))
            .toList();
        upcomingReminders = data
            .map<UpcomingReminders>(
              (item) => UpcomingReminders(
                  medication_name: item['medication_name'],
                  time: item['time'],
                  dosage: item['dosage']),
            )
            .toList();
      }
    } catch (e) {
      print('Error is $e');
    }
    return upcomingReminders;
  }

  // Getting user data from the backend using API
  void fetchData() async {
    try {
      String? access_token = await accessToken;
      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get-user-profile/'),
        headers: {'Authorization': 'Bearer $access_token'},
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(
          () {
            profile_pic = data['profile_pic'];
            full_name = data['full_name'];
          },
        );
        await storeUserData(full_name!, profile_pic!);
        print('Successfully fetched user profile and username');
      } else {
        String responseCode = data['code'];
        if (responseCode == "bad_authorization_header") {
          print("Access token is empty!");
        }
        // refreshing the token using refresh token as the access token has eDxpired
        else {
          String? refresh_token = await refreshToken;
          http.Response refreshResponse = await http.post(
            Uri.parse('http://10.0.2.2:8000/api/token/refresh/'),
            body: {'refresh': refreshToken},
          );
          if (refreshResponse.statusCode == 200) {
            var refreshData = json.decode(refreshResponse.body);
            String newRefreshToken = refreshData['refresh'];
            String newAccessToken = refreshData['access'];
            await storage.write(
                key: 'SignInAccessToken', value: newAccessToken);
            await storage.write(
                key: 'SignInRefreshToken', value: newRefreshToken);

            setState(() {
              accessToken = Future.value(newAccessToken);
              refreshToken = Future.value(newRefreshToken);
            });
            fetchData();
          } else {
            print('Failed to refresh token');
          }
        }
      }
    } catch (e) {
      print('Error is $e');
    }
  }

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
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 100,
                  left: 20,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: profile_pic != null
                          ? NetworkImage(profile_pic!)
                          : const AssetImage('assets/images/luffy.jpg')
                              as ImageProvider,
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
                          full_name ?? "Monkey D. Luffy",
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ScanImage()));
                                  },
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Prescription()));
                                  },
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Reminder()));
                                  },
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
                            const SizedBox(height: 100),
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
                            // onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => const MyProfile()));
                            // },
                            onTap: () async {
                              bool? isProfileUpdated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyProfile()),
                              );
                              if (isProfileUpdated == true) {
                                fetchData(); // Re-fetch user data if the profile was updated
                              }
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScanImage(),
                            ));
                      },
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingReminders {
  String medication_name;
  String time;
  String dosage;
  UpcomingReminders({
    required this.medication_name,
    required this.time,
    required this.dosage,
  });
}

class UpcomingRemindersTimes {
  String time;
  String dosage;
  UpcomingRemindersTimes({
    required this.time,
    required this.dosage,
  });
}

// //Chat GPT
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});
// //   @override
// //   State<HomePage> createState() {
// //     return _HomePageState();
// //   }
// // }

// // class _HomePageState extends State<HomePage> {
// //   final storage = FlutterSecureStorage();
// //   Future<String?> accessToken = getSignInAccessToken();
// //   Future<String?> refreshToken = getSignInRefreshToken();

// //   List<ReminderTime> upcomingReminders = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchUpcomingReminders();
// //   }

// //   Future<void> fetchUpcomingReminders() async {
// //     try {
// //       final access_token = await accessToken;
// //       final response = await http.get(
// //         Uri.parse('http://10.0.2.2:8000/api/reminders/'),
// //         headers: {'Authorization': 'Bearer $access_token'},
// //       );

// //       if (response.statusCode == 200) {
// //         final List<dynamic> data = jsonDecode(response.body);
// //         List<ReminderTime> reminders = [];

// //         for (var item in data) {
// //           String medicationName = item['medication_name'];
// //           List<dynamic> times = item['times'];

// //           for (var timeEntry in times) {
// //             reminders.add(ReminderTime(
// //               medicationName: medicationName,
// //               time: timeEntry['time'],
// //               dosage: timeEntry['dosage'],
// //               unit: timeEntry['unit'],
// //             ));
// //           }
// //         }

// //         // Sort reminders by time
// //         reminders.sort((a, b) => a.time.compareTo(b.time));

// //         setState(() {
// //           upcomingReminders = reminders;
// //         });
// //       } else {
// //         print('Failed to fetch reminders');
// //       }
// //     } catch (e) {
// //       print('Error fetching reminders: $e');
// //     }
// //   }

// //   Widget buildReminderTile(ReminderTime reminder) {
// //     return Container(
// //       height: 80,
// //       margin: const EdgeInsets.only(bottom: 10),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(10),
// //         color: Colors.white,
// //         boxShadow: const [
// //           BoxShadow(
// //             color: Color.fromARGB(255, 212, 212, 212),
// //             offset: Offset(0, 10),
// //             blurRadius: 10.0,
// //             spreadRadius: -2,
// //           ),
// //         ],
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Image.asset('assets/images/upcoming_reminder_pills.png'),
// //             const SizedBox(width: 20),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     reminder.medicationName,
// //                     style: const TextStyle(
// //                       fontFamily: 'Lato',
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   Text(
// //                     'Dosage: ${reminder.dosage} ${reminder.unit}',
// //                     style: const TextStyle(
// //                       fontFamily: 'Lato',
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                   Row(
// //                     children: [
// //                       Image.asset('assets/images/upcoming_reminder_clock.png'),
// //                       const SizedBox(width: 5),
// //                       Text(
// //                         reminder.time,
// //                         style: const TextStyle(
// //                           fontFamily: 'Lato',
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         color: const Color.fromARGB(255, 242, 247, 250),
// //         child: Padding(
// //           padding: const EdgeInsets.all(20.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const SizedBox(height: 20),
// //               const Text(
// //                 "UPCOMING REMINDER",
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.w500,
// //                   fontFamily: 'Lato',
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               Expanded(
// //                 child: upcomingReminders.isEmpty
// //                     ? const Center(child: CircularProgressIndicator())
// //                     : ListView.builder(
// //                         itemCount: upcomingReminders.length,
// //                         itemBuilder: (context, index) {
// //                           return buildReminderTile(upcomingReminders[index]);
// //                         },
// //                       ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class ReminderTime {
// //   final String medicationName;
// //   final String time;
// //   final String dosage;
// //   final String unit;

// //   ReminderTime({
// //     required this.medicationName,
// //     required this.time,
// //     required this.dosage,
// //     required this.unit,
// //   });
// // }

// // Future<String?> getSignInAccessToken() async {
// //   const storage = FlutterSecureStorage();
// //   return await storage.read(key: 'SignInAccessToken');
// // }

// // Future<String?> getSignInRefreshToken() async {
// //   const storage = FlutterSecureStorage();
// //   return await storage.read(key: 'SignInRefreshToken');
// // }

// // Chat Gpt and Self
// import 'package:capstone_project/medication_reminder/add_medication.dart';
// import 'package:capstone_project/medication_reminder/reminder.dart';
// import 'dart:convert';
// import 'package:capstone_project/my_profile/my_profile.dart';
// import 'package:capstone_project/prescription_folder/prescription.dart';
// import 'package:capstone_project/scan/scan_image.dart';
// import 'package:capstone_project/sign_in.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:capstone_project/medication_reminder/reminder.dart';

// final RouteObserver<ModalRoute<void>> routeObserver =
//     RouteObserver<ModalRoute<void>>();

// // Storing user data in flutter secure storage
// Future<void> storeUserData(String fullName, String profilePic) async {
//   final storage = FlutterSecureStorage();
//   await storage.write(key: 'full_name', value: fullName);
//   await storage.write(key: 'profile_pic', value: profilePic);
// }

// // Fetching Stored Tokens From Flutter Secure Storage
// Future<String?> getUserFullName() async {
//   const storage = FlutterSecureStorage();
//   return await storage.read(key: 'full_name');
// }

// Future<String?> getUserProfilePic() async {
//   const storage = FlutterSecureStorage();
//   return await storage.read(key: 'profile_pic');
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() {
//     return _HomePageState();
//   }
// }

// class _HomePageState extends State<HomePage> {
//   List<ReminderTime> upcomingReminders = [];

//   // Fetching tokens form sign_in file and putting it in a varible
//   final storage = FlutterSecureStorage();
//   Future<String?> accessToken = getSignInAccessToken();
//   Future<String?> refreshToken = getSignInRefreshToken();

//   // Stating varibles to hold user data
//   String? profile_pic;
//   String? full_name;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     fetchUpcomingReminders();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     fetchData(); // Fetch profile picture or update state
//     fetchUpcomingReminders(); // Fetch upcoming reminders
//   }

// //Fetching upcoming reminders from the backend using API
//   Future<void> fetchUpcomingReminders() async {
//     try {
//       final access_token = await accessToken;
//       final response = await http.get(
//         Uri.parse('http://10.0.2.2:8000/api/reminders/'),
//         headers: {'Authorization': 'Bearer $access_token'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         List<ReminderTime> reminders = [];

//         for (var item in data) {
//           String medicationName = item['medication_name'];
//           List<dynamic> times = item['times'];

//           for (var timeEntry in times) {
//             reminders.add(ReminderTime(
//               medicationName: medicationName,
//               time: timeEntry['time'],
//               dosage: timeEntry['dosage'],
//               unit: timeEntry['unit'],
//             ));
//           }
//         }

//         // Sort reminders by time
//         reminders.sort((a, b) => a.time.compareTo(b.time));

//         setState(() {
//           upcomingReminders = reminders;
//         });
//       } else {
//         print('Failed to fetch reminders');
//       }
//     } catch (e) {
//       print('Error fetching reminders: $e');
//     }
//   }

//   // Getting user data from the backend using API
//   void fetchData() async {
//     try {
//       String? access_token = await accessToken;
//       http.Response response = await http.get(
//         Uri.parse('http://10.0.2.2:8000/api/get-user-profile/'),
//         headers: {'Authorization': 'Bearer $access_token'},
//       );
//       var data = json.decode(response.body);
//       if (response.statusCode == 200) {
//         setState(
//           () {
//             profile_pic = data['profile_pic'];
//             full_name = data['full_name'];
//           },
//         );
//         await storeUserData(full_name!, profile_pic!);
//         print('Successfully fetched user profile and username');
//       } else {
//         String responseCode = data['code'];
//         if (responseCode == "bad_authorization_header") {
//           print("Access token is empty!");
//         }
//         // refreshing the token using refresh token as the access token has eDxpired
//         else {
//           String? refresh_token = await refreshToken;
//           http.Response refreshResponse = await http.post(
//             Uri.parse('http://10.0.2.2:8000/api/token/refresh/'),
//             body: {'refresh': refreshToken},
//           );
//           if (refreshResponse.statusCode == 200) {
//             var refreshData = json.decode(refreshResponse.body);
//             String newRefreshToken = refreshData['refresh'];
//             String newAccessToken = refreshData['access'];
//             await storage.write(
//                 key: 'SignInAccessToken', value: newAccessToken);
//             await storage.write(
//                 key: 'SignInRefreshToken', value: newRefreshToken);

//             setState(() {
//               accessToken = Future.value(newAccessToken);
//               refreshToken = Future.value(newRefreshToken);
//             });
//             fetchData();
//           } else {
//             print('Failed to refresh token');
//           }
//         }
//       }
//     } catch (e) {
//       print('Error is $e');
//     }
//   }

//   Widget buildReminderTile(ReminderTime reminder) {
//     return Container(
//       height: 80,
//       margin: const EdgeInsets.only(bottom: 15),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromARGB(255, 212, 212, 212),
//             offset: Offset(0, 10),
//             blurRadius: 10.0,
//             spreadRadius: -2,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset('assets/images/upcoming_reminder_pills.png'),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     reminder.medicationName,
//                     style: const TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Dosage: ${reminder.dosage} ${reminder.unit}',
//                     style: const TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 14,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Image.asset('assets/images/upcoming_reminder_clock.png'),
//                       const SizedBox(width: 5),
//                       Text(
//                         reminder.time,
//                         style: const TextStyle(
//                           fontFamily: 'Lato',
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color.fromARGB(255, 242, 247, 250),
//         child: Stack(
//           children: [
//             Container(
//               height: 400,
//               color: const Color.fromARGB(255, 180, 177, 243),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   bottom: 100,
//                   left: 20,
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: profile_pic != null
//                           ? NetworkImage(profile_pic!)
//                           : const AssetImage('assets/images/luffy.jpg')
//                               as ImageProvider,
//                     ),
//                     SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Welcome!",
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 48, 48, 48),
//                             fontSize: 18,
//                             fontFamily: 'Lato',
//                           ),
//                         ),
//                         Text(
//                           full_name ?? "Monkey D. Luffy",
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 48, 48, 48),
//                             fontSize: 18,
//                             fontFamily: 'Lato',
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 const SizedBox(height: 200),
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 242, 247, 250),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(255, 186, 186, 186),
//                           offset: Offset(0, -2),
//                           blurRadius: 10.0,
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         top: 40,
//                         right: 20,
//                         left: 20,
//                         bottom: 80,
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             //search bar
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 right: 20,
//                                 left: 20,
//                                 bottom: 20,
//                               ),
//                               child: Container(
//                                 height: 40,
//                                 decoration: const BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Color.fromARGB(255, 212, 212, 212),
//                                       offset: Offset(0, 10),
//                                       blurRadius: 10.0,
//                                       spreadRadius: -2,
//                                     ),
//                                   ],
//                                 ),
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: 'Search',
//                                     contentPadding:
//                                         const EdgeInsets.symmetric(vertical: 0),
//                                     hintStyle: const TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         color: Color.fromARGB(150, 0, 0, 0)),
//                                     prefixIcon: const Icon(Icons.search),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     filled: true,
//                                     fillColor: const Color.fromARGB(
//                                         255, 255, 255, 255),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20),

//                             // Categories Section
//                             const Text(
//                               "CATEGORIES",
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Lato'),
//                             ),
//                             const SizedBox(height: 10),

//                             // Upload Prescription and Prescription Folder Row
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 // Upload Prescription Button
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => ScanImage()));
//                                   },
//                                   child: Container(
//                                     height: 110,
//                                     width: 175,
//                                     decoration: BoxDecoration(
//                                       color: const Color.fromARGB(
//                                           255, 255, 255, 255),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Color.fromARGB(
//                                               255, 212, 212, 212),
//                                           offset: Offset(0, 10),
//                                           blurRadius: 10.0,
//                                           spreadRadius: -2,
//                                         ),
//                                       ],
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Image.asset(
//                                             'assets/images/upload_prescription.png'),
//                                         const Text(
//                                           'UPLOAD',
//                                           style: TextStyle(
//                                             fontFamily: 'Lato',
//                                           ),
//                                         ),
//                                         const Text(
//                                           'PRESCRIPTION',
//                                           style: TextStyle(fontFamily: 'Lato'),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),

//                                 // Presctiption Floder Button
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const Prescription()));
//                                   },
//                                   child: Container(
//                                     height: 110,
//                                     width: 175,
//                                     decoration: BoxDecoration(
//                                       color: const Color.fromARGB(
//                                           255, 255, 255, 255),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Color.fromARGB(
//                                               255, 212, 212, 212),
//                                           offset: Offset(0, 10),
//                                           blurRadius: 10.0,
//                                           spreadRadius: -2,
//                                         ),
//                                       ],
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Image.asset(
//                                             'assets/images/prescription_folder.png'),
//                                         const Text(
//                                           'PRESCRIPTION',
//                                           style: TextStyle(
//                                             fontFamily: 'Lato',
//                                           ),
//                                         ),
//                                         const Text(
//                                           'FLODER',
//                                           style: TextStyle(fontFamily: 'Lato'),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 10),

//                             // Medication Reminder and Medication Chart Row
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 // Upload Prescription Button
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const Reminder()));
//                                   },
//                                   child: Container(
//                                     height: 110,
//                                     width: 175,
//                                     decoration: BoxDecoration(
//                                       color: const Color.fromARGB(
//                                           255, 255, 255, 255),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Color.fromARGB(
//                                               255, 212, 212, 212),
//                                           offset: Offset(0, 10),
//                                           blurRadius: 10.0,
//                                           spreadRadius: -2,
//                                         ),
//                                       ],
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Image.asset(
//                                             'assets/images/medication_reminder.png'),
//                                         const Text(
//                                           'MEDICATION',
//                                           style: TextStyle(
//                                             fontFamily: 'Lato',
//                                           ),
//                                         ),
//                                         const Text(
//                                           'REMINDER',
//                                           style: TextStyle(fontFamily: 'Lato'),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),

//                                 // Presctiption Floder Button
//                                 GestureDetector(
//                                   onTap: () {},
//                                   child: Container(
//                                     height: 110,
//                                     width: 175,
//                                     decoration: BoxDecoration(
//                                       color: const Color.fromARGB(
//                                           255, 255, 255, 255),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Color.fromARGB(
//                                               255, 212, 212, 212),
//                                           offset: Offset(0, 10),
//                                           blurRadius: 10.0,
//                                           spreadRadius: -2,
//                                         ),
//                                       ],
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Image.asset(
//                                             'assets/images/medication_chart.png'),
//                                         const Text(
//                                           'MEDICATION',
//                                           style: TextStyle(
//                                             fontFamily: 'Lato',
//                                           ),
//                                         ),
//                                         const Text(
//                                           'CHART',
//                                           style: TextStyle(fontFamily: 'Lato'),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 30),

//                             // Upcoming Reminder Row
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "UPCOMING REMINDER",
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: 'Lato'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {},
//                                   child: const Text(
//                                     "See All >",
//                                     style: TextStyle(
//                                         color: Color.fromARGB(200, 48, 48, 48),
//                                         fontFamily: "lato"),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: upcomingReminders.length,
//                               itemBuilder: (context, index) {
//                                 return buildReminderTile(
//                                     upcomingReminders[index]);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Container(
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 1,
//                           blurRadius: 5,
//                           offset: const Offset(0, -3),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 20,
//                         right: 20,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           // Home Button
//                           GestureDetector(
//                             onTap: () {},
//                             child: Container(
//                               height: 60,
//                               width: 60,
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset('assets/images/home_nav.png'),
//                                   const SizedBox(height: 5),
//                                   const Text(
//                                     'Home',
//                                     style: TextStyle(
//                                       fontFamily: 'lato',
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // Prescriptions Button
//                           GestureDetector(
//                             onTap: () {},
//                             child: Container(
//                               height: 60,
//                               width: 85,
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                       'assets/images/prescription_nav.png'),
//                                   const SizedBox(height: 5),
//                                   const Text(
//                                     'Prescriptions',
//                                     style: TextStyle(
//                                       fontFamily: 'lato',
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 60),

//                           // Notification Button
//                           GestureDetector(
//                             onTap: () {},
//                             child: Container(
//                               height: 60,
//                               width: 85,
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                       'assets/images/notification_nav.png'),
//                                   const SizedBox(height: 5),
//                                   const Text(
//                                     'Notifications',
//                                     style: TextStyle(
//                                       fontFamily: 'lato',
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // Account Button
//                           GestureDetector(
//                             // onTap: () {
//                             //   Navigator.push(
//                             //       context,
//                             //       MaterialPageRoute(
//                             //           builder: (context) => const MyProfile()));
//                             // },
//                             onTap: () async {
//                               bool? isProfileUpdated = await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const MyProfile()),
//                               );
//                               if (isProfileUpdated == true) {
//                                 fetchData(); // Re-fetch user data if the profile was updated
//                               }
//                             },

//                             child: Container(
//                               height: 60,
//                               width: 60,
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset('assets/images/profile_nav.png'),
//                                   const SizedBox(height: 5),
//                                   const Text(
//                                     'Account',
//                                     style: TextStyle(
//                                       fontFamily: 'lato',
//                                       fontSize: 14,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: -30,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ScanImage(),
//                             ));
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 239, 239, 252),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.3),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Image.asset('assets/images/camera_nav.png'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ReminderTime {
//   final String medicationName;
//   final String time;
//   final String dosage;
//   final String unit;

//   ReminderTime({
//     required this.medicationName,
//     required this.time,
//     required this.dosage,
//     required this.unit,
//   });
// }
