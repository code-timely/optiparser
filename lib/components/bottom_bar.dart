import 'package:flutter/material.dart';
import 'package:optiparser/screens/analysispage.dart';
import 'package:optiparser/screens/homepage.dart';
import 'package:optiparser/screens/searchpage.dart';

BottomAppBar buildBottomNavBar(BuildContext context) {
  return BottomAppBar(
    shape: const CircularNotchedRectangle(),
    notchMargin: 10.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.home),
          color: Colors.blueAccent,
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
        const SizedBox(width: 50), // Space for the floating action button
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnalysisPage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    ),
  );
}
