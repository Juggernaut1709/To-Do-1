import 'package:flutter/material.dart';
import 'package:todo1/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

// MAIN FUNCTION
void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('myBox2');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
