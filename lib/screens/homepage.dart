import 'package:flutter/material.dart';
import 'package:optiparser/components/summarybox.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File? _image;
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OptiParse',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Big Container with Summary
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              height: 250.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Weekly Summary',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Placeholder for animations (income, expense, net overall)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Summarybox(
                        title: 'Income',
                        amount: '\$2,500',
                        color: Colors.green,
                      ),
                      Summarybox(
                        title: 'Expense',
                        amount: '\$1,200',
                        color: Colors.red,
                      ),
                      Summarybox(
                        title: 'Net',
                        amount: '\$1,300',
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recent Transactions Section
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Title and Show More
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Show more action
                        },
                        child: const Text(
                          'Show More ->',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // Latest transactions list
                  SizedBox(
                    height: 100.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          5, // Adjust the number of transactions displayed
                      itemBuilder: (context, index) {
                        return Container(
                          width: 120.0,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Transaction ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                '- \$150',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 7, 6, 6),
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            const SizedBox(width: 50), // Space for the floating action button
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showOptions,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
