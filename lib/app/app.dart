import 'package:fashion/app/app_routes.dart';
import 'package:fashion/app/themes.dart';
import 'package:fashion/features/auth/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Fashion extends StatefulWidget {
  const Fashion({super.key});

  @override
  State<Fashion> createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.name,
      theme: Themes.lightTheme,
      onGenerateRoute: AppRoutes.route

    );
  }
}
