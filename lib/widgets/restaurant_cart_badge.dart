import 'package:flutter/material.dart';

class RestaurantCartBadge extends StatelessWidget {
  final int itemsCount;
  const RestaurantCartBadge({super.key, required this.itemsCount});

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(itemsCount.toString()),
      child: Icon(Icons.shopping_cart),
    );
  }
}
