import 'package:flutter/material.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';
import 'package:plovo/providers/cart_provider.dart';

class CartState extends StatefulWidget {
  final Widget child;
  const CartState({super.key, required this.child});

  @override
  State<CartState> createState() => _CartStateState();
}

class _CartStateState extends State<CartState> {
  final cart = Cart();

  void addDish(Dish dish) {
    setState(() {
      cart.addDish(dish);
    });
  }

  void removeDish(Dish dish) {
    setState(() {
      cart.removeDish(dish);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CartProvider(
      cart: cart,
      addDish: addDish,
      removeDish: removeDish,
      child: widget.child,
    );
  }
}
