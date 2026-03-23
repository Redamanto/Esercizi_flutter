import 'package:flutter/material.dart';

/* Premetto che per alcune scelte di design aggiuntive, ho chiesto aiuto all'AI
in tal modo da avere un consiglio sul design senza rovinarlo troppo.
Le parti di codice a me nuove sono state scritte a mano per memorizzarle meglio
dopo aver chiesto la loro funzione*/

class Esercizio3 extends StatefulWidget {
  const Esercizio3({super.key});

  @override
  State<Esercizio3> createState() => _Esercizio3State();
}

/* Usiamo SingleTickerProviderStateMixin per gestire le animazioni 
  dei due pulsanti */
class _Esercizio3State extends State<Esercizio3> with TickerProviderStateMixin {
  // Controller e Animazione per il Pollice Su (Gioia)
  late AnimationController _controllerUp;
  late Animation<double> _scaleAnimation;

  // Controller e Animazione per il Pollice Giù (Tristezza)
  late AnimationController _controllerDown;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // Qui configuro il pulsante gioia, dandogli l'animazione di ingrandimento.
    _controllerUp = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controllerUp, curve: Curves.easeInOut));

    // Configurazione Tristezza: Ciondolio (Rotazione)
    _controllerDown = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(begin: 0.0, end: 0.05),
            weight: 1,
          ), // Destra
          TweenSequenceItem(
            tween: Tween(begin: 0.05, end: -0.05),
            weight: 2,
          ), // Sinistra
          TweenSequenceItem(
            tween: Tween(begin: -0.05, end: 0.0),
            weight: 1,
          ), // Ritorno
        ]).animate(
          CurvedAnimation(parent: _controllerDown, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _controllerUp.dispose();
    _controllerDown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Feedback Animato",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight(300),
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // Imposto il colore dello sfondo dell'Appbar.
        // con withValues assegno un'opacità allo sfondo fornendogli un valore double
        backgroundColor: const Color.fromARGB(
          255,
          247,
          0,
          255,
        ).withValues(alpha: 0.4),
        elevation: 4,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Widget Pollice Su
            ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  IconButton(
                    onPressed: () => _controllerUp.forward(from: 0.0),
                    icon: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                          255,
                          222,
                          56,
                          255,
                        ).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(
                              255,
                              222,
                              56,
                              255,
                            ).withValues(alpha: 0.1),
                            blurRadius: 15.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.thumb_up_alt_rounded,
                        size: 100,
                        color: Color.fromARGB(255, 222, 56, 255),
                      ),
                    ),
                  ),
                  const Text(
                    "Gioia 🙂",
                    style: TextStyle(
                      color: Color.fromARGB(255, 185, 0, 209),
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Widget del Pollice Giù
            RotationTransition(
              turns: _shakeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Mantiene testo e icona vicini
                children: [
                  // 1. Aggiungiamo il Container speculare qui:
                  Container(
                    padding: const EdgeInsets.all(16), // Padding per il cerchio
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withValues(
                        alpha: 0.1,
                      ), // Sfondo grigio-blu molto chiaro
                      shape: BoxShape.circle, // Forma identica a Gioia
                      // Opzionale: un'ombra molto leggera per definirlo
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withValues(alpha: 0.05),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: IconButton(
                      // 2. Usiamo l'icona Filled/Rounded per coerenza
                      icon: const Icon(
                        Icons.thumb_down_alt_rounded,
                        size: 100,
                      ), // Grandezza coerente
                      color: Colors.blueGrey, // Colore triste
                      onPressed: () => _controllerDown.forward(from: 0.0),
                    ),
                  ),
                  const SizedBox(height: 10), // Spazio tra cerchio e testo
                  const Text(
                    "Tristezza 😟",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
