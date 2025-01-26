import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_provider/data/product_data.dart';
import 'package:sm_provider/models/product_model.dart';
import 'package:sm_provider/pages/cart_page.dart';
import 'package:sm_provider/pages/favorite_page.dart';
import 'package:sm_provider/providers/cart_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter shop",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "fav_button",
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "shopping_button",
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final ProductModel product = products[index];
          return Card(
            child: Consumer(
              builder: (BuildContext context, CartProvider cartProvider,
                  Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      // todo fill this
                      Text("0"),
                    ],
                  ),
                  subtitle: Text(
                    "\$${product.price.toString()}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addItem(
                            product.id,
                            product.title,
                            product.price,
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
