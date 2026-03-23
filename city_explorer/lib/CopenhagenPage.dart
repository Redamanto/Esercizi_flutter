import 'package:flutter/material.dart';

class CopenhagenPage extends StatefulWidget {
  const CopenhagenPage({super.key});

  @override
  State<CopenhagenPage> createState() => _CopenhagenPageState();
}

class _CopenhagenPageState extends State<CopenhagenPage> {
  // Mappa per gestire lo stato dei preferiti (ID città : booleano)
  final Map<int, bool> _favorites = {};

  // Dati di esempio per la lista
  final List<Map<String, String>> cities = [
    {"name": "Copenaghen", "image": "lib/assets/images/copenaghen.jpg"},
    {"name": "Stoccolma", "image": "lib/assets/images/stoccolma.jpg"},
    {"name": "Oslo", "image": "lib/assets/images/oslo.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Città del Nord"),
        centerTitle: true,
        elevation: 2,
      ),
      // Usiamo ListView per rendere l'intera pagina scrollabile ed evitare overflow
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 1. INTRODUZIONE
          const Text(
            "Benvenuto su CityExplorer!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Esplora le più belle città del Nord Europa, salva le tue preferite e pianifica il tuo prossimo viaggio.",
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
          ),
          const SizedBox(height: 24),

          // 2. TITOLO LISTA
          const Text(
            "Città disponibili",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          // 3. LISTA DI CARD (Generata dinamicamente)
          // Usiamo Column invece di ListView.builder qui perché siamo già dentro una ListView
          Column(
            children: cities.asMap().entries.map((entry) {
              int index = entry.key;
              var city = entry.value;
              bool isFavorite = _favorites[index] ?? false;

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    // Immagine con bordi arrotondati solo sopra
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.asset(
                        city['image']!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Nome città
                          Text(
                            city['name']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Icona Cuore (Gestione Stato)
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _favorites[index] = !isFavorite;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          // Bottone Scopri con SnackBar
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Stai partendo per ${city['name']}!",
                                  ),
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: const Text("Scopri"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
