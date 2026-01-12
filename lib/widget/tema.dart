import 'package:flutter/material.dart';

ThemeData frutigerAeroTheme = ThemeData(
  useMaterial3: true,

  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF4FC3F7),
    onPrimary: Colors.white,
    secondary: Color(0xFF81D4FA),
    onSecondary: Colors.white,
    surface: Color(0x66E1F5FE),
    onSurface: Color(0xFF0D47A1),
    background: Color(0xFFE1F5FE),
    onBackground: Color(0xFF01579B),
    error: Colors.redAccent,
    onError: Colors.white,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      ),

      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(10),

      overlayColor: WidgetStateProperty.resolveWith((state) {
        if (state.contains(MaterialState.hovered)) {
          return Colors.white.withOpacity(0.18);
        }
        if (state.contains(MaterialState.pressed)) {
          return Colors.white.withOpacity(0.25);
        }
        return null;
      }),
    ),
  ),

  textTheme: const TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
);
