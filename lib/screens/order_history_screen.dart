import 'package:flutter/material.dart';
import 'package:plovo/providers/order_provider.dart';
import 'package:plovo/widgets/center_loading_indicator.dart';
import 'package:plovo/widgets/center_placeholder.dart';
import 'package:plovo/widgets/order_card.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late OrderProvider orderProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchOrders();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderProvider = context.read<OrderProvider>();
  }

  @override
  void dispose() {
    Future.microtask(() {
      orderProvider.clearErrors();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    Widget body;

    if (orderProvider.isFetching) {
      body = CenterLoadingIndicator();
    } else if (orderProvider.isFetchError) {
      body = CenterPlaceholder(
        title: 'Something went wrong',
        iconData: Icons.error_outline,
        buttonText: 'Try again',
        onButtonPressed: () => orderProvider.fetchOrders(),
      );
    } else if (orderProvider.orders.isEmpty) {
      body = CenterPlaceholder(
        title: 'No orders yet',
        iconData: Icons.remove_shopping_cart_outlined,
        buttonText: 'Go back',
        onButtonPressed: () => Navigator.of(context).pop(),
      );
    } else {
      body = ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: orderProvider.orders.length,
        separatorBuilder: (ctx, i) => Divider(),
        itemBuilder:
            (ctx, i) => OrderCard(order: orderProvider.orders[i], onTap: () {}),
      );
    }

    return Scaffold(appBar: AppBar(title: Text('Order history')), body: body);
  }
}
