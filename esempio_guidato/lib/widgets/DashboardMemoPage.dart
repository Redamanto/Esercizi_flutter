import 'package:flutter/material.dart';

// Creo il nuovo widget DashboardMemoPage.
class DashboardMemoPage extends StatelessWidget {
  const DashboardMemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* MediaQuery.of è la proprietà che si occupa di salvare le dimensioni dello
    schermo */
    final size = MediaQuery.of(context).size;

    Widget _statCard(String label, String value, Color bgColor) {
      return Container(
        width: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    Widget _buildStatsRow() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statCard("Totali", "24", Colors.blue.shade100),
          _statCard("Completati", "12", Colors.green.shade100),
          _statCard("Urgenti", "3", Colors.red.shade100),
        ],
      );
    }

    // Funzione che fornisce un colore in base alla priorità
    Color _rowColor(String priority, bool completed) {
      if (completed) return Colors.green.shade100;
      if (priority.toLowerCase() == "urgente")
        return const Color.fromARGB(255, 226, 156, 167);
      return Colors.white;
    }

    TableRow _tableRow(
      String title,
      String data,
      String priority,
      bool completed,
    ) {
      return TableRow(
        decoration: BoxDecoration(color: _rowColor(priority, completed)),
        children: [
          Padding(padding: const EdgeInsets.all(8), child: Text(title)),
          Padding(padding: const EdgeInsets.all(8), child: Text(data)),
          Padding(padding: const EdgeInsets.all(8), child: Text(priority)),
        ],
      );
    }

    TableRow _tableHeader() {
      return const TableRow(
        decoration: BoxDecoration(color: Colors.black12),
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Titolo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text("Data", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Priorità",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }

    Widget _buildTableArea() {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            _tableHeader(),
            _tableRow(
              "Preparare presentazione",
              "20/03/2026",
              "Urgente",
              false,
            ),
            _tableRow("Spesa settimanale", "21/03/2026", "Normale", false),
            _tableRow("Chiamare Marco", "20/03/2026", "Normale", false),
          ],
        ),
      );
    }

    // Costruzionee del pannello laterale.
    Widget _buildSidePanel() {
      return Container(
        // Stili per la costruzione del pannello.
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Note Rapide",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Aggiungo il widget SizedBox per aumentare la distanza tra gli oggetti
            SizedBox(height: 16),
            Text("- Ricordarsi di inviare email a Giulia"),
            SizedBox(height: 8),
            Text("- Aggiornare la lista dei progetti"),
            SizedBox(height: 8),
            Text("- Preparare i materiali per la riunione"),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Memo")),

      // La dashboard sarà costruita qui, all'interno del body.
      /* EdgeInsets.all specifica la dimensione del widget. Inoltre
        il padding sarà responsivo, cioè si adatterà in base alla dimensione
        dello schermo del dispositivo su cui l'app sta runnando.*/
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        // Qui c'è la barra delle statistiche, la sezione centrale ed  altri
        // elementi
        child: Column(
          // CrossAxisAlignment allinea gli elementi, in questo caso a sinistra
          // con .start
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inserimento delle cards.
            const SizedBox(height: 12),
            _buildStatsRow(),
            const SizedBox(height: 20),
            // Contenuto principale
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTableArea(),
                    const SizedBox(height: 20),
                    _buildSidePanel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
