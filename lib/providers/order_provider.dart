import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plovo/helpers/request.dart';
import 'package:plovo/models/order.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderListItem> _orders = [];
  bool _isFetching = false;
  bool _isFetchError = false;
  bool _isCreating = false;

  List<OrderListItem> get orders => _orders;
  bool get isFetching => _isFetching;
  bool get isFetchError => _isFetchError;
  bool get isCreating => _isCreating;

  Future<void> fetchOrders() async {
    try {
      _isFetching = true;
      _isFetchError = false;
      notifyListeners();

      final url = '${dotenv.env['BASE_URL']}/orders.json';
      final Map<String, dynamic>? response = await request(url);
      final List<OrderListItem> newOrders = [];

      if (response == null) {
        _orders = [];
        return;
      }

      for (final key in response.keys) {
        final Map<String, dynamic> orderJson = {...response[key], 'id': key};

        final order = OrderListItem.fromJson(orderJson);
        newOrders.add(order);
      }

      _orders = newOrders;
    } catch (e) {
      _isFetchError = true;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> createOrder(CreateOrderRequest orderRequest) async {
    try {
      _isCreating = true;
      notifyListeners();

      final url = '${dotenv.env['BASE_URL']}/orders.jsonE';

      await request(url, method: 'POST', body: orderRequest.toJson());
    } finally {
      _isCreating = false;
      notifyListeners();
    }
  }

  void clearErrors() {
    _isFetchError = false;
    notifyListeners();
  }
}
