import 'package:capstone_project/help_and_faqs.dart';
import 'package:capstone_project/home_page.dart';
import 'package:capstone_project/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:capstone_project/components/alert_dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});
  @override
  State<MyProfile> createState() {
    return _MyProfileState();
  }
}

class _MyProfileState extends State<MyProfile> {
  // Accessing flutter secure storage
  final storage = FlutterSecureStorage();

  Future<void> deleteTokens = deleteSignInTokens();

  final ImagePicker _picker = ImagePicker();
  File? _image;

  //function to pick image
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print("No image selected");
    }
  }

  //Function to show option to select image
  void _imagePickerOptions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void logout() {}

  // logout dialog box
  bool tappedYes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Top section with the colored background
          Container(
            width: MediaQuery.of(context).size.width,
            height: 900,
            color: const Color.fromARGB(255, 180, 177, 243),
          ),
          // Background with curved corners
          Positioned(
            top: 200, // Start after the 240 height
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), // Adjust radius as needed
                topRight: Radius.circular(30), // Adjust radius as needed
              ),
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
          //Content
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                    ),
                    const SizedBox(width: 73),
                    const Text(
                      'My Profile',
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
                //Profile Picture
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _imagePickerOptions,
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('assets/images/user.png')
                            as ImageProvider,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                //Username
                const SizedBox(height: 10),
                const Text(
                  'Username',
                ),
                //Edit Profile
                const SizedBox(height: 10),
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontFamily: 'Lato',
                    fontSize: 16,
                  ),
                ),
                //Profile List
                //Personal Information
                const SizedBox(height: 15),
                ListTile(
                  leading: Image.asset(
                    'assets/images/personalInformation.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Personal Information',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontSize: 20,
                        fontFamily: 'Lato'),
                  ),
                  subtitle: Text(
                    'View your Personal Information',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onTap: () {},
                ),
                //Medical Information
                const SizedBox(height: 15),
                ListTile(
                  leading: Image.asset(
                    'assets/images/medicalInformation.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Medical Information',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontSize: 20,
                        fontFamily: 'Lato'),
                  ),
                  subtitle: Text(
                    'View your medical Information',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onTap: () {},
                ),
                //Settings
                const SizedBox(height: 15),
                ListTile(
                  leading: Image.asset(
                    'assets/images/settings.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontSize: 20,
                        fontFamily: 'Lato'),
                  ),
                  subtitle: Text(
                    'Customize your app preferences',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onTap: () {},
                ),
                //Account Management
                const SizedBox(height: 15),
                ListTile(
                  leading: Image.asset(
                    'assets/images/accountManagement.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Account Management',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontSize: 20,
                        fontFamily: 'Lato'),
                  ),
                  subtitle: Text(
                    'Manage your account details and security',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onTap: () {},
                ),
                //Help and FAQs
                const SizedBox(height: 15),
                ListTile(
                  leading: Image.asset(
                    'assets/images/help.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Help & FAQs',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontSize: 20,
                        fontFamily: 'Lato'),
                  ),
                  subtitle: Text(
                    'Find answers and support',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HelpAndFaqs()));
                  },
                ),
                //Log Out
                const SizedBox(height: 15),
                ListTile(
                  leading: Image.asset(
                    'assets/images/logout.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontSize: 20,
                        fontFamily: 'Lato'),
                  ),
                  subtitle: Text(
                    'Log Out from your prescriptAid account',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onTap: () async {
                    // final action = await AlertDialogs.yesCancelDialog(
                    //     context, 'Logout', 'are you sure?');
                    // if (action == DialogsAction.yes) {
                    //   setState(() => tappedYes = true);
                    // } else {
                    //   setState(() => tappedYes = false);
                    // }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                const Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Lato',
                                      fontSize: 28),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Are you sure you want to logout?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'Lato',
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 251, 251, 251),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                  255, 209, 209, 209),
                                              offset: const Offset(0, 5),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'lato',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                    GestureDetector(
                                      onTap: () async {
                                        await deleteTokens;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignIn()));
                                        Future<String?> accessToken =
                                            getSignInAccessToken();
                                        Future<String?> refreshToken =
                                            getSignInRefreshToken();
                                        String? access_token =
                                            await accessToken;
                                        String? refresh_token =
                                            await refreshToken;
                                        print(
                                            'Accesstoken after deleting: $access_token');
                                        print(
                                            'Refreshtoken after deleting: $refresh_token');
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 251, 251, 251),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                  255, 209, 209, 209),
                                              offset: const Offset(0, 5),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'lato',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
