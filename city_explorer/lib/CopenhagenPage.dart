import 'package:flutter/material.dart';

class CopenhagenPage extends StatelessWidget {
  const CopenhagenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Esplora Copenhagen'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView( // Permette di scorrere se il contenuto è lungo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Immagine principale della città
            Image.network(
              'https://images.unsplash.com/photo-1513107313057-5274c5aa23a8', 
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Benvenuti a Copenhagen',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'La capitale della Danimarca è famosa per i suoi canali, la Sirenetta e il design moderno. Una città perfetta da girare in bicicletta!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  
                  const Text(
                    'Top Attractions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  
                  // Lista attrazioni (come richiesto dal PDF)
                  _buildAttractionTile('I Giardini di Tivoli', 'Il secondo parco divertimenti più antico al mondo.'),
                  _buildAttractionTile('Nyhavn', 'Il celebre canale con le case colorate.'),
                  _buildAttractionTile('La Sirenetta', 'L\'icona della città ispirata alla fiaba di Andersen.'),
                  
                  const SizedBox(height: 30),
                  
                  // Pulsante Prenota
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Logica per la prenotazione (es. un popup)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Prenotazione completata per Copenhagen!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: const Text('Prenota Ora', style: TextStyle(color: Colors.white)),
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

  // Funzione helper per creare le righe delle attrazioni
  Widget _buildAttractionTile(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.location_on, color: Colors.redAccent),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}