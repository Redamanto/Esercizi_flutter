import 'package:flutter/material.dart';
import 'esercizio3.dart'; // Importiamo il secondo file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Rimuovo il banner "Debug" che appare in alto a
      // destra quando runno l'app
      debugShowCheckedModeBanner: false,
      title: 'Feedback Animato',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const Esercizio3(),
    );
  }
}
