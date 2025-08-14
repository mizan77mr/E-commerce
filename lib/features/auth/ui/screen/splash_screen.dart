import 'package:fashion/app/assets_path.dart';
import 'package:fashion/features/auth/ui/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static final String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _moveToNextScreen();

    });

    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    Future.delayed(Duration(seconds: 4));
   Navigator.pushReplacementNamed(context, OnboardingScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              strokeAlign: 70,
              value: 1,
            ),
          ),
          Spacer(),

          Center(child: SvgPicture.asset(AssetsPath.logo, height: 200)),
          Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              strokeAlign: 130,
              value: 1,
            ),
          ),
        ],
      ),
    );
  }
}
