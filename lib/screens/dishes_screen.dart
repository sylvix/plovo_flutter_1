import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/providers/dishes_provider.dart';
import 'package:plovo/providers/restaurant_provider.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/dish_card.dart';

class DishesScreen extends ConsumerWidget {
  const DishesScreen({super.key});

  void onCartButtonPressed(BuildContext context, String restaurantId) async {
    await Navigator.of(
      context,
    ).pushNamed(AppRoutes.cart, arguments: restaurantId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
    final restaurant = ref.watch(restaurantByIdProvider(restaurantId));
    final dishes = ref.watch(dishesByRestaurantIdProvider(restaurantId));
    final cart = ref.watch(cartByRestaurantIdProvider(restaurantId));
    final total = cart.total;

    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            GridView.builder(
              padding: EdgeInsets.only(top: 16, bottom: bottomPadding + 60),
              itemCount: dishes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 300,
              ),
              itemBuilder:
                  (ctx, i) => DishCard(
                    dish: dishes[i],
                    onAdded:
                        () =>
                            ref.read(cartProvider.notifier).addDish(dishes[i]),
                  ),
            ),
            if (total > 0)
              ActionButton(
                onPressed: () => onCartButtonPressed(context, restaurantId),
                child: Text('View cart - ${total.toStringAsFixed(2)} KGS'),
              ),
          ], //
        ),
      ),
    );
  }
}
