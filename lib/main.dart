import 'package:app_shared_pref/app_setting.dart';
import 'package:app_shared_pref/auto_complete_page.dart';
import 'package:app_shared_pref/my_home_page.dart';
import 'package:app_shared_pref/preferences_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: AppSetting(),
    );
  }
}

