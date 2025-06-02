import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:plovo/screens/home_navigation_screen.dart';
import 'package:plovo/theme/light_theme.dart';

class PlovoApp extends ConsumerWidget {
  const PlovoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(theme: lightTheme, home: HomeNavigationScreen());
  }
}
