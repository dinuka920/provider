import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_provider/models/cart_provider_model.dart';
import 'package:sm_provider/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart Page",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder:
            (BuildContext context, CartProvider cartProvider, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final CartItemModel cartItemModel =
                        cartProvider.items.values.toList()[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(76, 255, 86, 34),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(cartItemModel.title),
                        subtitle: Text(
                            "\$${cartItemModel.price.toString()} x ${cartItemModel.quantity}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartProvider.removeSingleItem(cartItemModel.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("One item removed!"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(Icons.remove),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.removeItem(cartItemModel.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Removed from cart!"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(Icons.remove_shopping_cart),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
