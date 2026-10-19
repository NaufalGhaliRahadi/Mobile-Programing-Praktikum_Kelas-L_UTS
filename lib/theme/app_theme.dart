import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF14532D); // hijau tua
  static const accent = Color(0xFFF59E0B); // oranye
  static const background = Color(0xFFF4F8F1); // hijau sangat pucat
  static const card = Colors.white;
  static const textDark = Color(0xFF1F2937);
  static const textMuted = Color(0xFF6B7280);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
