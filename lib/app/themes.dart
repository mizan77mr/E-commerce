import 'package:fashion/app/app_colors.dart';
import 'package:flutter/material.dart';

class Themes{
  static ThemeData get lightTheme{
    return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.getMaterialColor(AppColors.themeColor)
    ),
    textTheme: TextTheme(

      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.1,
      ),

      titleSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,

      ),
    )
    );

  }



}