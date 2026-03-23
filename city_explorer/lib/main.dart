import 'package:flutter/material.dart';
import 'CopenhagenPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Città del Nord',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // look moderno
      ),
      // 2. Imposta CopenhagenPage come home
      home: const CopenhagenPage(),
      debugShowCheckedModeBanner: false, // Rimuove il banner "Debug"
    );
  }
}
