import 'package:capstone_project/home_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});
  @override
  State<MyProfile> createState() {
    return _MyProfileState();
  }
}

class _MyProfileState extends State<MyProfile> {
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
                  onTap: () {},
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
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
