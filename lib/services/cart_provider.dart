import 'package:flutter/material.dart';
import '../../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  double get totalAmount {
    return _items.values.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  void addItem(String id, String name, String image, double price) {
    if (_items.containsKey(id)) {
      // Update quantity
      _items[id]!.quantity++;
    } else {
      // Add new item
      _items[id] = CartItem(
        id: id,
        name: name,
        image: image,
        price: price,
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
