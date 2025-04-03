import 'package:flutter/material.dart';
import 'package:plovo/screens/restaurants_screen.dart';
import 'package:plovo/theme/light_theme.dart';

class PlovoApp extends StatelessWidget {
  const PlovoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: lightTheme, home: RestaurantsScreen());
  }
}
