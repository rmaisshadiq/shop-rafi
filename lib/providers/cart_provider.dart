import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<String?> checkout() async {
    final url = "https://backend-shop-production-fbd7.up.railway.app/checkout";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "items": _cartItems,
          "total_amount": totalPrice,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _cartItems.clear();
        notifyListeners();
        return data['payment_url'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error Provider: $e");
      return null;
    }
  }
}
