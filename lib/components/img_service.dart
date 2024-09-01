import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImgService {
  File? _image;
  final picker = ImagePicker();
  final Dio dio = Dio(); // Initialize Dio

  // Show options to get image from camera or gallery
  Future<Map<String, dynamic>> showOptions(BuildContext context) async {
    // Completer to return data when fetched
    final completer = Completer<Map<String, dynamic>>();

    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () async {
              // Close the options modal
              Navigator.of(context).pop();

              // Get image from gallery
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                _image = File(pickedFile.path);
                var data = await sendImageToModel(_image!);
                completer
                    .complete(data); // Complete the completer with fetched data
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              // Close the options modal
              Navigator.of(context).pop();

              // Get image from camera
              final pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                _image = File(pickedFile.path);
                var data = await sendImageToModel(_image!);
                completer
                    .complete(data); // Complete the completer with fetched data
              }
            },
          ),
        ],
      ),
    );

    return completer.future; // Return the data when it becomes available
  }

  // Function to send the selected image to the server and return the data
  Future<Map<String, dynamic>> sendImageToModel(File imageFile) async {
    const url = "http://52.140.76.58:8000/api/upload/";

    FormData formData = FormData.fromMap({
      'file':
          await MultipartFile.fromFile(imageFile.path, filename: 'upload.jpg'),
    });

    // try {
    //   Response response = await dio.post(url, data: formData);

    //   if (response.statusCode == 200) {
    //     print('Response JSON: ${response.data}');
    //     return fetchDetectedData(response.data['file']);
    //   } else {
    //     print('Failed to send image. Status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   print('Error occurred while sending image: $e');
    // }
    // // Return an empty map if there's an error
    // return {};

    return fetchDetectedData("hasdfadf.jpg");
  }

  // Function to fetch detected data using the file name received from the server
  Future<Map<String, dynamic>> fetchDetectedData(String fileName) async {
    const url = "http://52.140.76.58:8000/api/detect/";

    // try {
    //   Response response = await dio.get(
    //     url,
    //     queryParameters: {'file_name': fileName},
    //   );

    //   if (response.statusCode == 200) {
    //     print('Detected Data: ${response.data}');
    //     return {
    //       'title': response.data['title'],
    //       'amount': response.data['amount'],
    //       // Add more fields if needed
    //     };
    //   } else {
    //     print(
    //         'Failed to fetch detected data. Status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   print('Error occurred while fetching detected data: $e');
    // }

    // // Return an empty map if there's an error
    // return {};
    Map<String, dynamic> data = {
      'date': "02/09/2024",
      'invoice_id': "1234567890ABC",
      'vendors_name': "Manas Jain Kuniya",
      'buyer_name': "this_is_mjk",
      'total_amount': 500.00,
    };
    return data;
  }
}














// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:optiparser/screens/homepage.dart';

// class ImgService {
//   File? _image;
//   final picker = ImagePicker();
//   final Dio dio = Dio(); // Initialize dio

//   // Show options to get image from camera or gallery
//   Future showOptions(BuildContext context) async {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         actions: [
//           CupertinoActionSheetAction(
//             child: const Text('Photo Gallery'),
//             onPressed: () async {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from gallery
//               final pickedFile =
//                   await picker.pickImage(source: ImageSource.gallery);
//               _image = File(pickedFile!.path);
//               var data = await sendImageToModel(_image!);
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: const Text('Camera'),
//             onPressed: () async {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from camera
//               final pickedFile =
//                   await picker.pickImage(source: ImageSource.camera);
//               _image = File(pickedFile!.path);
//               var data = await sendImageToModel(_image!);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Future<Map<String, dynamic>>> sendImageToModel(File imageFile) async {
//     const url = "http://52.140.76.58:8000/api/upload/";

//     FormData formData = FormData.fromMap({
//       'file':
//           await MultipartFile.fromFile(imageFile.path, filename: 'upload.jpg'),
//     });

//     // try {
//     //   Response response = await dio.post(url, data: formData);

//     //   if (response.statusCode == 200) {
//     //     log.i('Response JSON: ${response.data}');
//     //     return fetchDetectedData(response.data.file);
//     //   } else {
//     //     log.i('Failed to send image. Status code: ${response.statusCode}');
//     //   }
//     // } catch (e) {
//     //   log.i('Error occurred while sending image: $e');
//     // }
//     return fetchDetectedData("hasdfadf.jpg");
//   }

//   Future<Map<String, dynamic>> fetchDetectedData(String fileName) async {
//     const url = "http://52.140.76.58:8000/api/detect/";

//     // TODO: once the server is working take the navigator code inside the try block
//     // try {
//     //   Response response = await dio.get(
//     //     url,
//     //     queryParameters: {'file_name': fileName},
//     //   );

//     //   if (response.statusCode == 200) {
//     //     log.i('Detected Data: ${response.data}');
//     //   } else {
//     //     log.i(
//     //         'Failed to fetch detected data. Status code: ${response.statusCode}');
//     //   }
//     // } catch (e) {
//     //   log.i('Error occurred while fetching detected data: $e');
//     // }
//     // Map<String, dynamic> initialData = {
//     //   'title': response.data['title'],
//     //   'amount': response.data['amount'],
//     //   // Add more fields if needed
//     // };
//     Map<String, dynamic> data = {
//       'date': "02/09/2024",
//       "invlice_id": "1234567890ABC",
//       "Vendors_name": "Manas Jain Kuniya",
//       "buyer_name": "this_is_mjk",
//     };
//     return data;
//   }
// }

// // // Image Picker function to get image from gallery
// //   Future getImageFromGallery() async {
// //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
// //     _image = File(pickedFile!.path);
// //     sendImageToModel(_image!);
// //   }

// //   // Image Picker function to get image from camera
// //   Future getImageFromCamera() async {
// //     final pickedFile = await picker.pickImage(source: ImageSource.camera);
// //     _image = File(pickedFile!.path);
// //     sendImageToModel(_image!);
// //   }
