import 'package:flutter/material.dart';

class InfoTourPage extends StatefulWidget {
  final String cityName;

  const InfoTourPage({super.key, required this.cityName});

  @override
  State<InfoTourPage> createState() => _InfoTourPageState();
}

class _InfoTourPageState extends State<InfoTourPage> {
  final _formKey = GlobalKey<FormState>(); // Chiave per la validazione
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info Tour: ${widget.cityName}")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo Città: Precompilato e NON modificabile (readOnly)
              TextFormField(
                initialValue: widget.cityName,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Città selezionata",
                  prefixIcon: Icon(Icons.location_city),
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "La tua Email",
                  hintText: "esempio@email.it",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "L'email è obbligatoria";
                  }

                  if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value)) {
                    return "Inserisci un indirizzo email valido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo Messaggio (Textarea)
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Messaggio",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Il messaggio non può essere vuoto";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Pulsante Invia
              ElevatedButton(
                onPressed: () {
                  // Se il form è valido, mostro la conferma
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Richiesta inviata con successo!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Torna indietro dopo 2 secondi
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Invia Richiesta"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
