import 'package:fashion/app/app_colors.dart';
import 'package:fashion/features/auth/ui/screen/onboarding/onboarding_two_screen.dart';
import 'package:fashion/features/auth/ui/widgets/onboarding_screen_style.dart';
import 'package:flutter/material.dart';

class OnboardingOneScreen extends StatefulWidget {
  const OnboardingOneScreen({super.key});

  static final String name = '/onboarding-one';

  @override
  State<OnboardingOneScreen> createState() => _OnboardingOneScreenState();
}

class _OnboardingOneScreenState extends State<OnboardingOneScreen> {
  @override
  Widget build(BuildContext context) {
    return OnboardingStyle(
      titleSpans: [
        TextSpan(text: 'Wishlist: where '),
        TextSpan(
          text: 'Fashion Dreams ',
          style: TextStyle(color: AppColors.themeColor),
        ),
        TextSpan(text: 'Begin'),
      ],
      description:
          '''This is the most straightforward method for displaying placeholder text within the Android Studio layout editor, which is particularly useful for visual design and previewing''',
      currentIndex: 1,
      totalPages: 3,
      onBack: () {},
      onNext: () {
        Navigator.pushNamed(context, OnboardingTwoScreen.name);
      },
    );
  }
}
