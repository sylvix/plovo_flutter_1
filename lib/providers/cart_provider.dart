import 'package:flutter/material.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';

class CartProvider extends InheritedWidget {
  final Map<String, Cart> carts;
  final Cart Function(String restaurantId) getCart;
  final void Function(Dish dish) addDish;
  final void Function(Dish dish) removeDish;

  const CartProvider({
    super.key,
    required this.carts,
    required this.getCart,
    required this.addDish,
    required this.removeDish,
    required super.child,
  });

  static CartProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>();
  }

  @override
  bool updateShouldNotify(covariant CartProvider oldWidget) {
    final cartsLengthChanged = carts.length != oldWidget.carts.length;
    final anyCartChanged = carts.entries.any((entry) {
      final oldCart = oldWidget.carts[entry.key];
      return oldCart == null || entry.value != oldCart;
    });

    return cartsLengthChanged || anyCartChanged;
  }
}
