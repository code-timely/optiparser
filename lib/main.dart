// lib/main.dart

import 'package:flutter/material.dart';
import 'package:optiparser/components/loading_transition.dart';
import 'package:optiparser/screens/homepage.dart';
// import 'package:optiparser/screens/searchpage.dart';
import 'package:optiparser/storage/initialise_objectbox.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await initializeObjectBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OptiParse',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: LoadingPage(),
      home: const HomePage(),
      // home: const SearchPage(),
    );
  }
}
