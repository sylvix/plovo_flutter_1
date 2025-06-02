import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/providers/order_provider.dart';
import 'package:plovo/widgets/center_loading_indicator.dart';
import 'package:plovo/widgets/center_placeholder.dart';
import 'package:plovo/widgets/order_card.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(ordersListProvider);

    Widget body = switch (ordersState) {
      AsyncData(value: final orders) =>
        orders.isEmpty
            ? CenterPlaceholder(
              title: 'No orders yet',
              iconData: Icons.remove_shopping_cart_outlined,
              buttonText: 'Go back',
              onButtonPressed: () => Navigator.of(context).pop(),
            )
            : ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: orders.length,
              separatorBuilder: (ctx, i) => Divider(),
              itemBuilder:
                  (ctx, i) => OrderCard(order: orders[i], onTap: () {}),
            ),
      AsyncError() => CenterPlaceholder(
        title: 'Something went wrong',
        iconData: Icons.error_outline,
        buttonText: 'Try again',
        onButtonPressed: () => ref.invalidate(ordersListProvider),
      ),
      _ => CenterLoadingIndicator(),
    };

    return Scaffold(appBar: AppBar(title: Text('Order history')), body: body);
  }
}
