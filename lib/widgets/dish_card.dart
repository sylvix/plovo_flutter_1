import 'package:flutter/material.dart';
import 'package:plovo/models/dish.dart';

class DishCard extends StatelessWidget {
  final Dish dish;
  final void Function() onAdded;

  const DishCard({super.key, required this.dish, required this.onAdded});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: AssetImage(dish.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Text(
                      dish.name,
                      style: theme.textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${dish.price.toStringAsFixed(2)} KGS',
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: onAdded,
                    label: Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
