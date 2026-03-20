import 'package:flutter/material.dart';
import 'widgets/DashboardMemoPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DashBoard App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),

      home: const DashboardMemoPage(),
    );
  }
}
