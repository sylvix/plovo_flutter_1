import 'package:flutter/material.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';
import 'package:plovo/models/restaurant.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/cart_dish_tile.dart';

class CartScreen extends StatefulWidget {
  final String restaurantId;
  final Cart cart;
  const CartScreen({super.key, required this.restaurantId, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Restaurant restaurant;

  @override
  void initState() {
    super.initState();
    restaurant = restaurantsData.firstWhere(
      (restaurant) => restaurant.id == widget.restaurantId,
    );
  }

  void addDish(Dish dish) {
    setState(() {
      widget.cart.addDish(dish);
    });
  }

  void removeDish(Dish dish) {
    setState(() {
      widget.cart.removeDish(dish);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your cart - ${restaurant.name}')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: widget.cart.cartDishes.length,
              separatorBuilder: (ctx, i) => Divider(),
              itemBuilder: (ctx, i) {
                final cartDish = widget.cart.cartDishes[i];
                return CartDishTile(
                  cartDish: cartDish,
                  onAdded: () => addDish(cartDish.dish),
                  onRemoved: () => removeDish(cartDish.dish),
                );
              },
            ),
            ActionButton(child: Text('Go to checkout'), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
