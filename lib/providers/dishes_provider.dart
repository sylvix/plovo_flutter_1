import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/data/dishes_data.dart';
import 'package:plovo/models/dish.dart';

final dishesProvider = Provider((ref) {
  return restaurantDishes;
});

final dishesByRestaurantIdProvider = Provider.family<List<Dish>, String>((
  ref,
  restaurantId,
) {
  final dishes = ref.watch(dishesProvider);
  return dishes.where((dish) => dish.restaurantId == restaurantId).toList();
});
