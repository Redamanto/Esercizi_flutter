import 'package:flutter/material.dart';
import 'product.dart';
import 'ProductRepository.dart';
import 'package:provider/provider.dart';

class ProductSummaryPage extends StatelessWidget {
  final Product? product;

  const ProductSummaryPage({super.key, this.product});

  // Creazione della struttura per mostrare i dati:
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductRepository>().products;
    return Scaffold(
      appBar: AppBar(title: const Text('Riepilogo prodotto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Prodotti"),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(
                        p.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${p.id}'),
                          Text(
                            p.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: Text(
                        '€${p.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
