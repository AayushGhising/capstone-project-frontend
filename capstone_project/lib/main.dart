import 'package:camera/camera.dart';
import 'package:capstone_project/scan/scan_image.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/loading_screen.dart';
import 'package:capstone_project/help_and_faqs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MaterialApp(
    home: Scaffold(
      body: LoadingScreen(),
      // body: ScanImage(),
    ),
  ));
}
