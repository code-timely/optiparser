import 'package:flutter/material.dart';
import 'package:optiparser/screens/analysispage.dart';
import 'package:optiparser/screens/homepage.dart';
import 'package:optiparser/screens/searchpage.dart';
import 'package:optiparser/screens/profilepage.dart';

BottomAppBar buildBottomNavBar(BuildContext context) {
  return BottomAppBar(
    height: 40,
    shape: const CircularNotchedRectangle(),
    notchMargin: 10.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          // padding: EdgeInsets.all(10),
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
        const SizedBox(width: 10), // Space for the floating action button
        IconButton(
          icon: const Icon(Icons.analytics),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AnalysisPage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );},
        ),
      ],
    ),
  );
}
