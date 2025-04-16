import 'package:flutter/material.dart';
import 'package:plovo/app_routes.dart';
import 'package:plovo/screens/cart_screen.dart';
import 'package:plovo/screens/checkout_screen.dart';
import 'package:plovo/screens/dishes_screen.dart';
import 'package:plovo/screens/restaurants_screen.dart';
import 'package:plovo/theme/light_theme.dart';

class PlovoApp extends StatelessWidget {
  const PlovoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (ctx) => RestaurantsScreen(),
        AppRoutes.dishes: (ctx) => DishesScreen(),
        AppRoutes.cart: (ctx) => CartScreen(),
        AppRoutes.checkout: (ctx) => CheckoutScreen(),
      },
    );
  }
}
