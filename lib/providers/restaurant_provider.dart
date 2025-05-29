import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/data/restaurants_data.dart';
import 'package:plovo/models/restaurant.dart';

final restaurantsProvider = Provider((ref) {
  return restaurantsData;
});

final restaurantByIdProvider = Provider.family<Restaurant, String>((ref, id) {
  final restaurants = ref.watch(restaurantsProvider);
  return restaurants.firstWhere((restaurant) => restaurant.id == id);
});
