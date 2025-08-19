import 'package:fashion/app/app_colors.dart';
import 'package:fashion/features/Home/ui/sreen/home_screen.dart';
import 'package:flutter/material.dart';

class OnboardingThreeScreen extends StatefulWidget {
  const OnboardingThreeScreen({super.key});

  static final String name = 'onboarding-three';

  @override
  State<OnboardingThreeScreen> createState() => _OnboardingThreeScreenState();
}

class _OnboardingThreeScreenState extends State<OnboardingThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            height: 550,
            width: double.infinity,
            child: Stack(
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                  strokeAlign: 130,
                  value: 1,
                  color: AppColors.themeColor.withOpacity(0.4),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 90,

                        child: Container(
                          height: 400,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.network(
                              'https://i.pinimg.com/736x/50/3b/b4/503bb4703219b3e067de7fc599f07d7f.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 190,
                        child: Container(
                          height: 223,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.network(
                              'https://i.pinimg.com/736x/97/f5/d6/97f5d62a4dc31f3604fd25f372d43774.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 330,
                        left: 190,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 170,
                            width: 170,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://i.pinimg.com/736x/e5/99/5d/e5995d25a9d52990b2d43d5939920797.jpg',
                              height: 100,
                              width: 100,

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 360,
                  top: 300,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    value: 1,
                    strokeAlign: 110,
                    color: AppColors.themeColor.withOpacity(0.4),
                  ),
                ),

                Positioned(
                  top: 400,
                  left: 8,
                  child: Text('*', style: TextStyle(fontSize: 70)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.titleLarge,
              children: [
                TextSpan(text: 'The '),
                TextSpan(
                  text: 'Fashion App ',
                  style: TextStyle(color: AppColors.themeColor),
                ),
                TextSpan(text: 'That Makes You Look Your Best'),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              '''
          This is the most straightforward method for displaying placeholder text within the Android Studio layout editor, which is particularly useful for visual design and previewing
          ''',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.name,
                (predicate) => false,
              );
            },
            child: Text("Let's Get Started"),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?'),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sign In',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
