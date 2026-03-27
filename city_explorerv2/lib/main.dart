import 'package:flutter/material.dart';
import 'cittadelnord.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Explorer 2.0!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // look moderno
      ),
      // 2. Imposta CopenhagenPage come home
      home: const CittaDelNord(),
      debugShowCheckedModeBanner: false, // Rimuove il banner "Debug"
    );
  }
}
