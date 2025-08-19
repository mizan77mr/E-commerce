import 'package:fashion/app/app_colors.dart';
import 'package:fashion/features/auth/ui/screen/onboarding/onboarding_three_screen.dart';
import 'package:fashion/features/auth/ui/widgets/onboarding_screen_style.dart';
import 'package:flutter/material.dart';

class OnboardingTwoScreen extends StatefulWidget {
  const OnboardingTwoScreen({super.key});

  static final String name = 'onboarding-two';

  @override
  State<OnboardingTwoScreen> createState() => _OnboardingTwoScreenState();
}

class _OnboardingTwoScreenState extends State<OnboardingTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return OnboardingStyle(
      titleSpans: [
        TextSpan(
          text: 'Swift ',
          style: TextStyle(color: AppColors.themeColor),
        ),
        TextSpan(text: 'and '),
        TextSpan(
          text: 'Reliable \n',
          style: TextStyle(color: AppColors.themeColor),
        ),
        TextSpan(text: 'Delivery'),
      ],
      description:
          '''This is the most straightforward method for displaying placeholder text within the Android Studio layout editor, which is particularly useful for visual design and previewing''',
      currentIndex: 2,
      totalPages: 3,
      onNext: () {
        Navigator.pushNamed(context, OnboardingThreeScreen.name);
      },
      onBack: () {},
    );
  }
}
