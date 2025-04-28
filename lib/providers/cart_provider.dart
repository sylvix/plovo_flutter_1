import 'package:flutter/material.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';

class CartProvider extends ChangeNotifier {
  Map<String, Cart> _carts = {};

  Map<String, Cart> get carts => _carts;

  Cart getCart(String restaurantId) {
    return carts[restaurantId] ?? Cart(cartDishes: []);
  }

  void addDish(Dish dish) {
    _carts = {
      ..._carts,
      dish.restaurantId: getCart(dish.restaurantId).addDish(dish),
    };
    notifyListeners();
  }

  void removeDish(Dish dish) {
    _carts = {
      ..._carts,
      dish.restaurantId: getCart(dish.restaurantId).removeDish(dish),
    };
    notifyListeners();
  }
}
