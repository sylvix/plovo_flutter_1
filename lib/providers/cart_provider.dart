import 'package:flutter/material.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';

class CartProvider extends InheritedWidget {
  final Cart cart;
  final void Function(Dish dish) addDish;
  final void Function(Dish dish) removeDish;

  const CartProvider({
    super.key,
    required this.cart,
    required this.addDish,
    required this.removeDish,
    required super.child,
  });

  static CartProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>();
  }

  @override
  bool updateShouldNotify(covariant CartProvider oldWidget) {
    return true;
  }
}
