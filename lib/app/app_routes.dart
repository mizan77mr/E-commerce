import 'package:fashion/features/Home/ui/sreen/home_screen.dart';
import 'package:fashion/features/auth/ui/screen/onboarding/onboarding_one_screen.dart';
import 'package:fashion/features/auth/ui/screen/onboarding/onboarding_screen.dart';
import 'package:fashion/features/auth/ui/screen/onboarding/onboarding_three_screen.dart';
import 'package:fashion/features/auth/ui/screen/onboarding/onboarding_two_screen.dart';
import 'package:fashion/features/auth/ui/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> route(RouteSettings setting) {
    late final Widget screenWidget;
    if (setting.name == SplashScreen.name) {
      screenWidget = SplashScreen();
    } else if (setting.name == OnboardingScreen.name) {
      screenWidget = OnboardingScreen();
    } else if (setting.name == OnboardingOneScreen.name) {
      screenWidget = OnboardingOneScreen();
    } else if (setting.name == OnboardingTwoScreen.name) {
      screenWidget = OnboardingTwoScreen();
    } else if (setting.name == OnboardingThreeScreen.name) {
      screenWidget = OnboardingThreeScreen();
    } else if (setting.name == HomeScreen.name) {
      screenWidget = HomeScreen();
    }

    return MaterialPageRoute(builder: (context) => screenWidget);
  }
}
