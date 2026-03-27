import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importazione necessaria
import 'dart:convert'; // Per convertire i dati in JSON

// --- 1. SCHERMATA PRINCIPALE ---
class CittaDelNord extends StatefulWidget {
  const CittaDelNord({super.key});

  @override
  State<CittaDelNord> createState() => _CittaDelNordState();
}

class _CittaDelNordState extends State<CittaDelNord> {
  final Map<int, bool> _favorites = {};
  final Map<int, bool> _showInfoButton = {};

  final List<Map<String, String>> cities = [
    {
      "name": "Copenaghen",
      "image": "lib/assets/images/copenaghen.jpg",
      "desc": "La capitale della Danimarca, famosa per i canali e il design.",
    },
    {
      "name": "Stoccolma",
      "image": "lib/assets/images/stoccolma.jpg",
      "desc": "La Venezia del Nord, costruita su 14 isole.",
    },
    {
      "name": "Oslo",
      "image": "lib/assets/images/oslo.jpg",
      "desc":
          "Capitale norvegese, tra mare, musei vichinghi e natura incontaminata.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "City Explorer",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
      ),
      body: Row(
        children: [
          _buildFlagDecoration(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      const Text(
                        "Benvenuto su CityExplorer!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ...cities.asMap().entries.map((entry) {
                        int index = entry.key;
                        bool isFav = _favorites[index] ?? false;
                        bool canRequestInfo = _showInfoButton[index] ?? false;

                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 25,
                            left: 16,
                            right: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                child: Image.asset(
                                  entry.value['image']!,
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, e, s) => Container(
                                    height: 220,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          entry.value['name']!,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        FavoriteIcon(
                                          isFavorite: isFav,
                                          onTap: () => setState(
                                            () => _favorites[index] = !isFav,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () => setState(
                                            () => _showInfoButton[index] = true,
                                          ),
                                          child: const Text("Scopri"),
                                        ),
                                        if (canRequestInfo) ...[
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.orange.shade800,
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      InfoTourPage(
                                                        cityName: entry
                                                            .value['name']!,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "Richiedi informazioni",
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildFlagDecoration(),
        ],
      ),
    );
  }

  Widget _buildFlagDecoration() {
    return SizedBox(
      width: 12,
      child: Column(
        children: [
          Expanded(child: Container(color: const Color(0xFFC8102E))),
          Expanded(child: Container(color: const Color(0xFF005B96))),
          Expanded(child: Container(color: const Color(0xFFFCD116))),
          Expanded(child: Container(color: const Color(0xFFC8102E))),
          Expanded(child: Container(color: const Color(0xFF005B96))),
          Expanded(child: Container(color: const Color(0xFFFCD116))),
        ],
      ),
    );
  }
}

// --- 2. WIDGET CUORE ANIMATO ---
class FavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onTap;
  const FavoriteIcon({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });
  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(FavoriteIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite != oldWidget.isFavorite)
      _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.red.withValues(alpha: 0.3),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isFavorite ? Colors.red : Colors.white24,
              width: 2,
            ),
          ),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.isFavorite ? Colors.red : Colors.white54,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

// --- 3. PAGINA INFO TOUR CON CHIAMATA HTTP POST ---
// --- 3. SCHERMATA FORM INFO TOUR (FIX COLORI DARK) ---
class InfoTourPage extends StatefulWidget {
  final String cityName;
  const InfoTourPage({super.key, required this.cityName});

  @override
  State<InfoTourPage> createState() => _InfoTourPageState();
}

class _InfoTourPageState extends State<InfoTourPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _msgController = TextEditingController();
  bool _isSending = false;

  Future<void> sendInfoRequest() async {
    setState(() => _isSending = true);
    final url = Uri.parse('http://localhost:3000/infoTour');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "citta": widget.cityName,
          "email": _emailController.text,
          "messaggio": _msgController.text,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invio riuscito!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } else {
        throw Exception("Errore server");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Errore: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "Richiedi Informazioni",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1F1F1F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo Città (Lettura)
              TextFormField(
                initialValue: widget.cityName,
                readOnly: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ), // Testo Bianco
                decoration: InputDecoration(
                  labelText: "Città",
                  labelStyle: const TextStyle(
                    color: Colors.orangeAccent,
                  ), // Label Arancione
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.1),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.map, color: Colors.orangeAccent),
                ),
              ),
              const SizedBox(height: 20),
              // Campo Email
              TextFormField(
                controller: _emailController,
                style: const TextStyle(
                  color: Colors.white,
                ), // Testo Bianco mentre scrivi
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white70),
                  hintText: "Inserisci la tua email",
                  hintStyle: TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || !value.contains('@'))
                    ? "Inserisci email valida"
                    : null,
              ),
              const SizedBox(height: 20),
              // Campo Messaggio
              TextFormField(
                controller: _msgController,
                maxLines: 4,
                style: const TextStyle(
                  color: Colors.white,
                ), // Testo Bianco mentre scrivi
                decoration: const InputDecoration(
                  labelText: "Messaggio",
                  labelStyle: TextStyle(color: Colors.white70),
                  hintText: "Scrivi qui la tua richiesta...",
                  hintStyle: TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? "Messaggio obbligatorio"
                    : null,
              ),
              const SizedBox(height: 30),
              // Pulsante Invia
              _isSending
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent, // Sfondo Arancio
                        foregroundColor: Colors
                            .black, // Testo Nero (per contrasto su arancio)
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendInfoRequest();
                        }
                      },
                      child: const Text("Invia Richiesta"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
