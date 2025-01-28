import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_provider/data/product_data.dart';
import 'package:sm_provider/models/product_model.dart';
import 'package:sm_provider/providers/favourite_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Page",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer(
        builder: (
          BuildContext context,
          FavoriteProvider favoriteProvider,
          Widget? child,
        ) {
          final favItem = favoriteProvider.favourites.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();

          if (favItem.isEmpty) {
            return Center(
              child: Text("No favorites added yet!"),
            );
          }
          return ListView.builder(
            itemCount: favItem.length,
            itemBuilder: (context, index) {
              final productId = favItem[index];
              final ProductModel product = ProductData().products.firstWhere(
                    (product) => product.id == productId,
                  );
              return Card(
                child: ListTile(
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  trailing: IconButton(
                    onPressed: () {
                      favoriteProvider.toggleFavorites(product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Removed from favorites!",
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
