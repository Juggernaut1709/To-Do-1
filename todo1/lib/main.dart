import 'package:flutter/material.dart';
import 'package:todo1/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// MAIN FUNCTION

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('myBox2');
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the timezone data
  tz.initializeTimeZones();
  final String timeZoneName = tz.local.name;
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  // Initialize the local notification plugin
  runApp(MyApp());
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
