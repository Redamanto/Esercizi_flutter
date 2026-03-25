import 'package:flutter/material.dart';
import 'product.dart';
import 'ProductRepository.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Metodo che gestisce l'invio dei valori del form.
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: _idController.text.trim(),
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        description: _descriptionController.text.trim(),
      );

      try {
        // Se i dati inseriti sono corretti si raggiunge questa schermata:
        context.read<ProductRepository>().addProduct(product);
        context.push('/product-summary');
      } catch (e) {
        // Mostra un messaggio di errore
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Esiste già un prodotto con questo ID')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrazione del prodotto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID prodotto'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Inserisci un ID' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome prodotto'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Inserisci un nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Prezzo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Inserisci prezzo';
                  final parsed = double.tryParse(value);
                  if (parsed == null) return 'Inserisci un numero valido';
                  if (parsed <= 0) return 'Il prezzo deve essere maggiore di 0';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Nome prodotto'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Inserisci una descrizione'
                    : null,
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Conferma e continua'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.push('/product-summary'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Riepilogo prodotti',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
