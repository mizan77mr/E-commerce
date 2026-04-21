import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBarMessage(
  BuildContext context,
  String title, [
  bool isError = false,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: TextStyle(color: isError ? Colors.white : null),
      ),
      backgroundColor: isError? Colors.red:AppColors.themeColor,
    ),
  );
}
