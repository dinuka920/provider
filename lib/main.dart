import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_provider/pages/product_page.dart';
import 'package:sm_provider/providers/cart_provider.dart';
import 'package:sm_provider/providers/favourite_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}
