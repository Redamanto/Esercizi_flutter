import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  late AnimationController _controller;
  late Animation<double> _arrowRotation;

  final String fullText =
      "Questo è l'esercizio n3 e riguarda l'animazione in Flutter";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _arrowRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Testo di massimo 15 caratteri.
    final String shortText = '${fullText.substring(0, 15)}...';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 103, 186, 201),
        title: const Text("Animazione"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              _isExpanded ? _controller.forward() : _controller.reverse();
            });
          },
          // child: Container(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 163, 224, 240),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: Text(
                    _isExpanded ? fullText : shortText,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedBuilder(
                    animation: _arrowRotation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _arrowRotation.value * 3.14159,
                        child: Icon(
                          Icons.expand_more,
                          size: 32,
                          color: const Color.fromARGB(255, 148, 233, 245),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
