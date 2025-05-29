import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/providers/restaurant_provider.dart';
import 'package:plovo/widgets/restaurant_card.dart';

class RestaurantsScreen extends ConsumerWidget {
  const RestaurantsScreen({super.key});

  void onRestaurantSelected(BuildContext context, String restaurantId) {
    Navigator.of(context).pushNamed(AppRoutes.dishes, arguments: restaurantId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsData = ref.watch(restaurantsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Restaurants')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: restaurantsData.length,
          itemBuilder:
              (ctx, i) => RestaurantCard(
                restaurant: restaurantsData[i],
                onTap:
                    () => onRestaurantSelected(context, restaurantsData[i].id),
              ),
          separatorBuilder: (ctx, i) => SizedBox(height: 16),
        ),
      ),
    );
  }
}
