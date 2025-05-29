import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:plovo/providers/order_provider.dart';
import 'package:plovo/providers/user_provider.dart';
import 'package:plovo/screens/home_navigation_screen.dart';
import 'package:plovo/theme/light_theme.dart';
import 'package:provider/provider.dart';

class PlovoApp extends ConsumerWidget {
  const PlovoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ref.watch(userProvider.notifier)),
        ChangeNotifierProvider.value(value: ref.watch(orderProvider.notifier)),
      ],
      child: MaterialApp(theme: lightTheme, home: HomeNavigationScreen()),
    );
  }
}
