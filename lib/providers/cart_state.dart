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
  Map<String, Cart> carts = {};

  Cart getOrCreateCart(String restaurantId) {
    return carts[restaurantId] ?? Cart(cartDishes: []);
  }

  void addDish(Dish dish) {
    setState(() {
      carts = {
        ...carts,
        dish.restaurantId: getOrCreateCart(dish.restaurantId).addDish(dish),
      };
    });
  }

  void removeDish(Dish dish) {
    setState(() {
      carts = {
        ...carts,
        dish.restaurantId: getOrCreateCart(dish.restaurantId).removeDish(dish),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return CartProvider(
      carts: carts,
      getCart: getOrCreateCart,
      addDish: addDish,
      removeDish: removeDish,
      child: widget.child,
    );
  }
}
