import 'package:flutter/material.dart';
import 'package:plovo/providers/cart_provider.dart';
import 'package:plovo/providers/user_provider.dart';
import 'package:plovo/screens/home_navigation_screen.dart';
import 'package:plovo/theme/light_theme.dart';
import 'package:provider/provider.dart';

class PlovoApp extends StatelessWidget {
  const PlovoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(theme: lightTheme, home: HomeNavigationScreen()),
    );
  }
}
