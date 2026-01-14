import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0, (total, item) {
      // Handle potential String/int/double types for price
      var price = item['promo'];
      price ??= item['price'];
      if (price is String) {
        return total + (double.tryParse(price) ?? 0);
      } else if (price is int) {
        return total + price.toDouble();
      } else if (price is double) {
        return total + price;
      }
      return total;
    });
  }
}
