import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variabili
  bool _isSwitched = false;
  bool _mostraMessaggio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proteggi i pini e l'ambiente (esercizio n.1)"),
        backgroundColor: const Color.fromARGB(255, 88, 241, 177),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          /* Qui inserisco l'immagine che ho scaricato da internet. Ho preferito
          inserire un'immagine da locale, configurando il file pubsepc.yaml. */
          children: [
            Image(
              image: AssetImage('lib/assets/images/esercizio1.jpg'),
              width: 700.0, // larghezza dell'immagine in px
              height: 350.0, // altezza dellì immagine in px
            ),

            /* SizedBox() permette di creare uno spazio vuoto tra due oggetti.
             In questo caso l'ho applicato tra l'immagine che ho inserito e lo switch */
            const SizedBox(height: 10),

            /* Inserimento del widget Switch. Posso attivarlo o disattivarlo e in 
            base a questo darà un messaggio diverso */
            Switch(
              value: _isSwitched,
              onChanged: (value) {
                setState(() {
                  _isSwitched = value;
                });
              },
              activeThumbColor: Colors.green,
            ),

            // spaziatura di 10px tra lo switch e il testo che comparirà sotto.
            const SizedBox(height: 10),

            Text(
              _isSwitched
                  ? "Proteggi i pini"
                  : "Non proteggi i pini", // Il messaggio che comparirà in base allo stato dello switch
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _isSwitched ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 30), // Spazio extra tra i due esercizi
            // 2. MESSAGGIO CONDIZIONALE
            if (_mostraMessaggio)
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Salvaguardia anche tu l'ecosistema <3",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            // Qui creo i due bottoni e configuro la loro funzione.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _mostraMessaggio = true;
                    });
                  },
                  child: const Text("Mostra"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // setState è importante per poter cambiare lo stato di un widget.
                    setState(() {
                      _mostraMessaggio = false;
                    });
                  },
                  child: const Text("Nascondi"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
