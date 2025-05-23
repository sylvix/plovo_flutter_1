import 'package:flutter/material.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';
import 'package:plovo/models/restaurant.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/cart_dish_tile.dart';
import 'package:plovo/widgets/cart_empty.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Restaurant restaurant;
  late Cart cart;
  late CartProvider cartProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;

    restaurant = restaurantsData.firstWhere(
      (restaurant) => restaurant.id == restaurantId,
    );
    cartProvider = context.watch<CartProvider>();
    cart = cartProvider.getCart(restaurantId);
  }

  void addDish(Dish dish) {
    cartProvider.addDish(dish);
  }

  void removeDish(Dish dish) {
    cartProvider.removeDish(dish);
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

  void goToCheckout() {
    final navigator = Navigator.of(context);
    navigator.pushNamed(AppRoutes.checkout, arguments: restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final total = cart.total;

    return Scaffold(
      appBar: AppBar(title: Text('Your cart - ${restaurant.name}')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child:
            cart.cartDishes.isEmpty
                ? CartEmpty()
                : Stack(
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: bottomPadding + 60,
                      ),
                      itemCount: cart.cartDishes.length,
                      separatorBuilder: (ctx, i) => Divider(),
                      itemBuilder: (ctx, i) {
                        final cartDish = cart.cartDishes[i];
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
