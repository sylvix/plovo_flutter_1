import 'package:flutter/material.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/data/dishes_data.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';
import 'package:plovo/models/restaurant.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/widgets/action_button.dart';
import 'package:plovo/widgets/dish_card.dart';

class DishesScreen extends StatefulWidget {
  const DishesScreen({super.key});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  late Restaurant restaurant;
  List<Dish> dishes = [];
  late Cart cart;
  late CartProvider cartProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;

    restaurant = restaurantsData.firstWhere(
      (restaurant) => restaurant.id == restaurantId,
    );
    dishes =
        restaurantDishes
            .where((dish) => dish.restaurantId == restaurantId)
            .toList();
    cartProvider = CartProvider.of(context)!;
    cart = cartProvider.cart;
  }

  void onDishAdded(Dish dish) {
    cartProvider.addDish(dish);
  }

  void onCartButtonPressed() async {
    await Navigator.of(
      context,
    ).pushNamed(AppRoutes.cart, arguments: restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
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
                    onAdded: () => onDishAdded(dishes[i]),
                  ),
            ),
            if (total > 0)
              ActionButton(
                onPressed: onCartButtonPressed,
                child: Text('View cart - ${total.toStringAsFixed(2)} KGS'),
              ),
          ], //
        ),
      ),
    );
  }
}
