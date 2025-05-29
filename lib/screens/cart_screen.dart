import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/providers/restaurant_provider.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/cart_dish_tile.dart';
import 'package:plovo/widgets/cart_empty.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  late CartNotifier cartNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cartNotifier = ref.read(cartProvider.notifier);
  }

  void addDish(Dish dish) {
    cartNotifier.addDish(dish);
  }

  void removeDish(Dish dish) {
    cartNotifier.removeDish(dish);
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

  void goToCheckout(String restaurantId) {
    final navigator = Navigator.of(context);
    navigator.pushNamed(AppRoutes.checkout, arguments: restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
    final restaurant = ref.watch(restaurantByIdProvider(restaurantId));
    final cart = ref.watch(cartByRestaurantIdProvider(restaurantId));
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
                      onPressed: () => goToCheckout(restaurantId),
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
