import 'package:flutter/material.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';
import 'package:plovo/models/restaurant.dart';
import 'package:plovo/screens/checkout_screen.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/cart_dish_tile.dart';
import 'package:plovo/widgets/cart_empty.dart';

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

  void checkAndConfirmRemoval(CartDish cartDish) async {
    if (cartDish.amount == 1) {
      final isConfirmed = await showConfirmationDialog(cartDish.dish);

      if (isConfirmed != true) {
        return;
      }
    }

    removeDish(cartDish.dish);
  }

  Future<bool?> showConfirmationDialog(Dish dish) {
    return showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Remove dish'),
            content: Text(
              'Are you sure you want to remove ${dish.name} from your cart?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Remove'),
              ),
            ],
          ),
    );
  }

  void removeDish(Dish dish) {
    setState(() {
      widget.cart.removeDish(dish);
    });
  }

  void goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => CheckoutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final total = widget.cart.total;

    return Scaffold(
      appBar: AppBar(title: Text('Your cart - ${restaurant.name}')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child:
            widget.cart.cartDishes.isEmpty
                ? CartEmpty()
                : Stack(
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: bottomPadding + 60,
                      ),
                      itemCount: widget.cart.cartDishes.length,
                      separatorBuilder: (ctx, i) => Divider(),
                      itemBuilder: (ctx, i) {
                        final cartDish = widget.cart.cartDishes[i];
                        return CartDishTile(
                          cartDish: cartDish,
                          onAdded: () => addDish(cartDish.dish),
                          onRemoved: () => checkAndConfirmRemoval(cartDish),
                        );
                      },
                    ),
                    ActionButton(
                      onPressed: goToCheckout,
                      child: Text(
                        'Go to checkout - ${total.toStringAsFixed(2)} KGS',
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
