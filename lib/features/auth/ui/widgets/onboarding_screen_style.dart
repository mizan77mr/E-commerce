import 'package:flutter/material.dart';
import 'package:fashion/app/app_colors.dart';
import 'package:fashion/features/auth/ui/widgets/phone_mockup_ui.dart';

class OnboardingStyle extends StatelessWidget {
  final List<TextSpan> titleSpans;
  final String description;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final int currentIndex;
  final int totalPages;

  const OnboardingStyle({
    super.key,
    required this.titleSpans,
    required this.description,
    this.onNext,
    this.onBack,
    required this.currentIndex,
    required this.totalPages,
  });

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
                    onTap: onNext,
                    child: Text(
                      'Skip',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
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
                    top: MediaQuery.of(context).size.height * 0.55,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55),
                          topRight: Radius.circular(55),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.titleLarge,
                              children: titleSpans,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 34.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              description,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Back button
                              if (onBack != null)
                                InkWell(
                                  onTap: onBack,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.only(left: 32),
                                    decoration: BoxDecoration(
                                      color: AppColors.themeColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.arrow_back, color: Colors.white),
                                  ),
                                )
                              else
                                const SizedBox(width: 50),

                              // Dots indicator
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  totalPages,
                                      (index) => Container(
                                    height: 15,
                                    width: 15,
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index == currentIndex
                                          ? AppColors.themeColor
                                          : Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ),

                              // Next button
                              InkWell(
                                onTap: onNext,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(right: 32),
                                  decoration: BoxDecoration(
                                    color: AppColors.themeColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.arrow_forward, color: Colors.white),
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
