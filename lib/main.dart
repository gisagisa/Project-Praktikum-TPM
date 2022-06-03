import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:job/data/hive_database.dart';
import 'package:job/views/home.dart';
import 'package:job/views/register_page.dart';
import 'package:job/views/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/Job.dart';

void main() {
  _initDB();
  runApp(MyApp());
}

void _initDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JobAdapter());
  await Hive.openBox<Job>("jobdb");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Job',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegisterPage(),
    );
  }
}
