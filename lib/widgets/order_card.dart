import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plovo/models/order.dart';

final dateFormat = DateFormat('MMM d, y, HH:mm');

class OrderCard extends StatelessWidget {
  final OrderListItem order;
  final void Function() onTap;
  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Ink(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: AssetImage(order.restaurantImage)),
        ),
      ),
      title: Text(order.restaurantName),
      subtitle: Text(
        dateFormat.format(order.createdAt),
        style: theme.textTheme.labelMedium,
      ),
      trailing: Text(
        '${order.total.toStringAsFixed(2)} KGS',
        style: theme.textTheme.titleMedium,
      ),
      onTap: onTap,
    );
  }
}
