import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.getMaterialColor(AppColors.themeColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: _getInputBorder(AppColors.themeColor),
        enabledBorder: _getInputBorder(AppColors.themeColor),
        focusedBorder: _getInputBorder(AppColors.themeColor),
        errorBorder: _getInputBorder(AppColors.themeColor),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
      ),

      textTheme: _textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(double.maxFinite),
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 12),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static OutlineInputBorder _getInputBorder(Color color) {
    return OutlineInputBorder(borderSide: BorderSide(color: color, width: 1.5));
  }

  static TextTheme get _textTheme {
    return TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        letterSpacing: .4,
        fontWeight: FontWeight.w600,
      ),

      titleMedium: TextStyle(
        fontSize: 24,
        letterSpacing: .4,
        fontWeight: FontWeight.w600,
      ),

      titleSmall: TextStyle(
        fontSize: 22,
        letterSpacing: .4,
        fontWeight: FontWeight.w600,
      ),

      headlineMedium: TextStyle(fontSize: 16, color: Colors.grey),
    );
  }
}
