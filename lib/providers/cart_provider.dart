import 'package:flutter/foundation.dart';
import 'package:sm_provider/models/cart_provider_model.dart';

class CartProvider extends ChangeNotifier {
  // cart item state
  Map<String, CartItemModel> _items = {};

  // getter
  Map<String, CartItemModel> get items {
    return {..._items};
  }

  // add item
  void addItem(String productId, String productTitle, double productPrice) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItemModel(
          id: productId,
          title: productTitle,
          price: productPrice,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // remove cart
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // remove single item from cart
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // clear cart
  void clearAllCarts() {
    _items = {};
    notifyListeners();
  }

  // calculate total price of selected carts
  double get totalPrice {
    var total = 0.0;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.quantity;
      },
    );
     notifyListeners();
    return total;
    
  }
}
