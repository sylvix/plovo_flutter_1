import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plovo/helpers/request.dart';
import 'package:plovo/models/order.dart';
import 'package:plovo/widgets/center_loading_indicator.dart';
import 'package:plovo/widgets/center_placeholder.dart';
import 'package:plovo/widgets/order_card.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<OrderListItem> orders = [];
  bool isFetching = false;

  void fetchOrders() async {
    try {
      setState(() => isFetching = true);
      final url = '${dotenv.env['BASE_URL']}/orders.json';
      final Map<String, dynamic>? response = await request(url);
      final List<OrderListItem> newOrders = [];

      if (response == null) {
        setState(() => orders = []);
        return;
      }

      for (final key in response.keys) {
        final Map<String, dynamic> orderJson = {...response[key], 'id': key};
        final order = OrderListItem.fromJson(orderJson);
        newOrders.add(order);
      }

      setState(() => orders = newOrders);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Something went wrong!')));
      }
    } finally {
      setState(() => isFetching = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (isFetching) {
      body = CenterLoadingIndicator();
    } else if (orders.isEmpty) {
      body = CenterPlaceholder(
        title: 'No orders yet',
        iconData: Icons.remove_shopping_cart_outlined,
        buttonText: 'Go back',
        onButtonPressed: () => Navigator.of(context).pop(),
      );
    } else {
      body = ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: orders.length,
        separatorBuilder: (ctx, i) => Divider(),
        itemBuilder: (ctx, i) => OrderCard(order: orders[i], onTap: () {}),
      );
    }

    return Scaffold(appBar: AppBar(title: Text('Order history')), body: body);
  }
}
