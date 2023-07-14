import 'package:bmi_calculator/pages/home_page.dart';
import 'package:bmi_calculator/persistence/shared_preferences.dart';
import 'package:bmi_calculator/persistence/sqflite.dart';
import 'package:bmi_calculator/utils/theming.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await initDb();
  await initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "$kAppTitle",
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomePage(),
    );
  }
}
