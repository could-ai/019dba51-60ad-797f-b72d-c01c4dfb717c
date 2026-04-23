import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00FF7F); // Neon green
  static const Color backgroundColor = Color(0xFF121212); // Deep dark
  static const Color cardColor = Color(0xFF1E1E1E); // Slightly lighter dark
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color accentColor = Color(0xFF00C853);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: cardColor,
        background: backgroundColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: primaryColor),
      ),
      cardTheme: CardTheme(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: textPrimary, fontSize: 32, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
      ),
    );
  }
}
