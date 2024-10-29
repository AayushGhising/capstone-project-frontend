import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ScannedImagePreview extends StatefulWidget {
  ScannedImagePreview(this.file, {super.key});
  XFile file;
  @override
  State<ScannedImagePreview> createState() {
    return _ScannedImagePreviewState();
  }
}

class _ScannedImagePreviewState extends State<ScannedImagePreview> {
  // For cropping image
  late File _imageFile;
  @override
  void initState() {
    super.initState();
    _imageFile = File(widget.file.path);
  }

  Future<void> _cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Color.fromARGB(255, 111, 112, 231),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
      ],
    );
    if (croppedFile != null) {
      setState(
        () {
          _imageFile = File(croppedFile.path);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // File image = File(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Image Preview',
          style: TextStyle(fontFamily: 'lato', fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 180, 177, 243),
      ),
      body: Container(
        color: const Color.fromARGB(255, 242, 247, 250),
        child: Column(
          children: [
            Container(
              height: ((MediaQuery.of(context).size.width * 4) / 3) + 80,
              width: MediaQuery.of(context).size.width,
              color: Color.fromARGB(255, 48, 48, 48),
              child: Center(
                child: Image.file(_imageFile),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _cropImage, // Triggers the cropping functionality
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 111, 112, 231),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Crop Image',
                          style: TextStyle(
                            fontFamily: 'lato',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/crop.png'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 111, 112, 231),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Analyse',
                          style: TextStyle(
                            fontFamily: 'lato',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/scan.png'),
                      ],
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

// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';

// class ScannedImagePreview extends StatefulWidget {
//   ScannedImagePreview(this.file, {super.key});
//   XFile file;
//   @override
//   State<ScannedImagePreview> createState() {
//     return _ScannedImagePreviewState();
//   }
// }

// class _ScannedImagePreviewState extends State<ScannedImagePreview> {
//   late File _imageFile;

//   @override
//   void initState() {
//     super.initState();
//     _imageFile = File(widget.file.path);
//   }

//   Future<void> _cropImage() async {
//     final croppedFile = await ImageCropper().cropImage(
//       sourcePath: _imageFile.path,
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           toolbarColor: Color.fromARGB(255, 111, 112, 231),
//           toolbarWidgetColor: Colors.white,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: false,
//           aspectRatioPresets: [
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio3x2,
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.ratio4x3,
//             CropAspectRatioPreset.ratio16x9
//           ],
//         ),
//         IOSUiSettings(
//           title: 'Crop Image',
//           aspectRatioPresets: [
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio3x2,
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.ratio4x3,
//             CropAspectRatioPreset.ratio16x9
//           ],
//         ),
//       ],
//     );
//     if (croppedFile != null) {
//       setState(
//         () {
//           _imageFile = File(croppedFile.path);
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Image Preview',
//           style: TextStyle(fontFamily: 'lato', fontWeight: FontWeight.bold),
//         ),
//         foregroundColor: Colors.white,
//         backgroundColor: const Color.fromARGB(255, 180, 177, 243),
//       ),
//       body: Container(
//         color: const Color.fromARGB(255, 242, 247, 250),
//         child: Column(
//           children: [
//             Container(
//               height: ((MediaQuery.of(context).size.width * 4) / 3) + 80,
//               width: MediaQuery.of(context).size.width,
//               color: const Color.fromARGB(255, 48, 48, 48),
//               child: Center(
//                 child: Image.file(_imageFile),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: _cropImage, // Trigger the crop functionality
//                   child: Container(
//                     height: 50,
//                     width: 180,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: const Color.fromARGB(255, 111, 112, 231),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Crop Image',
//                           style: TextStyle(
//                             fontFamily: 'lato',
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Image.asset('assets/images/crop.png'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {}, // Add functionality for 'Analyse' later
//                   child: Container(
//                     height: 50,
//                     width: 180,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: const Color.fromARGB(255, 111, 112, 231),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Analyse',
//                           style: TextStyle(
//                             fontFamily: 'lato',
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Image.asset('assets/images/scan.png'),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
