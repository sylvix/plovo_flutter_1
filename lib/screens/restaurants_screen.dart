import 'package:flutter/material.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/widgets/restaurant_card.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  void onRestaurantSelected(BuildContext context, String restaurantId) {
    Navigator.of(context).pushNamed(AppRoutes.dishes, arguments: restaurantId);
  }

  @override
  Widget build(BuildContext context) {
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
