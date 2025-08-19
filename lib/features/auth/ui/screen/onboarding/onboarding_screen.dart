import 'dart:ui';
import 'package:fashion/app/app_colors.dart';
import 'package:fashion/features/auth/ui/screen/onboarding/onboarding_one_screen.dart';
import 'package:fashion/features/auth/ui/widgets/onboarding_screen_style.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static final String name = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return OnboardingStyle(
      titleSpans: [
        TextSpan(
          text: 'Seamless ',
          style: TextStyle(color: AppColors.themeColor),
        ),
        TextSpan(text: 'Shopping Experience'),
      ],
      description:
          '''This is the most straightforward method for displaying placeholder text within the Android Studio layout editor, which is particularly useful for visual design and previewing''',
      currentIndex: 0,
      totalPages: 3,
      onNext: () {
        Navigator.pushNamed(context, OnboardingOneScreen.name);
      },
    );
  }
}
