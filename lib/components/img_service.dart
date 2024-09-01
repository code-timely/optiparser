import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optiparser/screens/homepage.dart';

class ImgService {
  File? _image;
  final picker = ImagePicker();
  final Dio dio = Dio(); // Initialize dio
  // Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    sendImageToModel(_image!);
  }

  // Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    sendImageToModel(_image!);
  }

  // Show options to get image from camera or gallery
  Future showOptions(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  Future<void> sendImageToModel(File imageFile) async {
    // const url = 'https://webhook.site/96040912-4aa1-4bad-8b12-5c77fcbe7cef';
    const url = "http://52.140.76.58:8000/api/upload";

    FormData formData = FormData.fromMap({
      'file':
          await MultipartFile.fromFile(imageFile.path, filename: 'upload.jpg'),
    });

    try {
      Response response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        log.i('Response JSON: ${response.data}');
      } else {
        log.i('Failed to send image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log.i('Error occurred while sending image: $e');
    }
  }
}
