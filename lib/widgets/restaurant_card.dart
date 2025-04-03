import 'package:flutter/material.dart';
import 'package:plovo/models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final void Function() onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Ink(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: AssetImage(restaurant.image)),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  restaurant.name,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Icon(Icons.chevron_right, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
