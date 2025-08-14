import 'package:fashion/app/app_colors.dart';
import 'package:fashion/features/auth/ui/screen/onboarding_three_screen.dart';
import 'package:fashion/features/auth/ui/widgets/phone_mockup_ui.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OnboardingThreeScreen.name);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: PhoneMockUi(),
                  ),
                  Positioned(
                    top: 500,
                    child: Container(
                      height: 400,
                      width: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.titleLarge,
                              children: [
                                TextSpan(
                                  text: 'Swift ',
                                  style: TextStyle(color: AppColors.themeColor),
                                ),
                                TextSpan(text: 'and '),
                                TextSpan(
                                  text: 'Reliable\n',
                                  style: TextStyle(color: AppColors.themeColor),
                                ),
                                TextSpan(text: 'Delivery'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 34.0,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              '''This is the most straightforward method for displaying placeholder text within the Android Studio layout editor, which is particularly useful for visual design and previewing''',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor: AppColors.themeColor,
                                    foregroundColor: Colors.white,
                                  ),

                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_back),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 110),
                              for (int i = 0; i < 3; i++)
                                Container(
                                  height: 15,
                                  width: 15,
                                  margin: EdgeInsets.only(left: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.themeColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),

                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor: AppColors.themeColor,
                                    foregroundColor: Colors.white,
                                  ),

                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
