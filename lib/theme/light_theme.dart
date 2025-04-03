import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepOrange);
final defaultLightTheme = ThemeData.light();

final lightTheme = defaultLightTheme.copyWith(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: lightColorScheme.onPrimaryContainer,
    foregroundColor: lightColorScheme.primaryContainer,
  ),
  cardTheme: defaultLightTheme.cardTheme.copyWith(
    margin: EdgeInsets.zero,
    color: lightColorScheme.onPrimary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);
