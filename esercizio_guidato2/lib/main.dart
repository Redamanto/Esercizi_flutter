import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "ProductFormPage.dart";
import 'ProductSummaryPage.dart';
import 'product.dart';
import 'ProductRepository.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductRepository(),
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/product-form',
      builder: (context, state) => const ProductFormPage(),
    ),
    GoRoute(
      path: '/product-summary',
      builder: (context, state) {
        final product = state.extra as Product?;
        return ProductSummaryPage(product: product);
      },
    ),
  ],
  initialLocation: '/product-form',
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Product Registration',
      routerConfig: _router,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
    );
  }
}
