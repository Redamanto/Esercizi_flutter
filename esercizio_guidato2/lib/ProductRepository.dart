import 'package:flutter/material.dart';
import 'product.dart';

// Questa classe estende ChangeNotifier che è a sua volta una classe Flutter
// che notifica la UI se ci sono cambiamenti.
class ProductRepository extends ChangeNotifier {
  /* Setto la lista in sola lettura grazide a unmodifiable che impedisce
  ulteriori modifiche dall'esterno */
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  bool existsById(String id) {
    return _products.any((p) => p.id == id);
  }

  // addProduct è un metodo per aggiungere elementi nella lista.
  void addProduct(Product product) {
    if (existsById(product.id)) {
      throw Exception('ID già esistente');
    }

    _products.add(product);
    notifyListeners();
  }
}
