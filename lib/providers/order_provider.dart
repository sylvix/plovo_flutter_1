import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/helpers/request.dart';
import 'package:plovo/models/order.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/providers/restaurant_provider.dart';
import 'package:plovo/providers/user_provider.dart';

final ordersListProvider = FutureProvider.autoDispose<List<OrderListItem>>((
  ref,
) async {
  final url = '${dotenv.env['BASE_URL']}/orders.json';
  final Map<String, dynamic>? response = await request(url);

  if (response == null) {
    return [];
  }

  final List<OrderListItem> newOrders = [];

  for (final key in response.keys) {
    final Map<String, dynamic> orderJson = {...response[key], 'id': key};
    final order = OrderListItem.fromJson(orderJson);
    newOrders.add(order);
  }

  return newOrders;
});

class CreateOrderNotifier extends AsyncNotifier<void> {
  @override
  build() {}

  Future<void> createOrder(String restaurantId) async {
    final restaurant = ref.read(restaurantByIdProvider(restaurantId));
    final cart = ref.read(cartByRestaurantIdProvider(restaurantId));
    final user = ref.read(userProvider);

    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (user == null) {
        throw Exception('User not found');
      }

      final orderRequest = CreateOrderRequest(
        restaurant: restaurant,
        cartDishes: cart.cartDishes,
        user: user,
        createdAt: DateTime.now(),
      );

      final url = '${dotenv.env['BASE_URL']}/orders.jsonE';
      await request(url, method: 'POST', body: orderRequest.toJson());
    });
  }
}

final createOrderProvider = AsyncNotifierProvider<CreateOrderNotifier, void>(
  CreateOrderNotifier.new,
);
