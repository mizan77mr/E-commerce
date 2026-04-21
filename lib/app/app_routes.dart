import 'package:crafty_bay/features/Order/ui/screen/shipping_address_screen.dart';
import 'package:crafty_bay/features/auth/ui/screen/login_screen.dart';
import 'package:crafty_bay/features/auth/ui/screen/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/ui/screen/splash_screen.dart';
import 'package:crafty_bay/features/auth/ui/screen/verify_otp_screen.dart';
import 'package:crafty_bay/features/common/model/category_model.dart';
import 'package:crafty_bay/features/common/ui/screen/main_bottom_nav_screen.dart';
import 'package:crafty_bay/features/product/ui/screen/create_product_reviews_screen.dart';
import 'package:crafty_bay/features/product/ui/screen/product_details_screen.dart';
import 'package:crafty_bay/features/product/ui/screen/product_list_screen.dart';
import 'package:crafty_bay/features/product/ui/screen/product_reviews_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings setting) {
    late final Widget screenWidgets;
    if (setting.name == SplashScreen.name) {
      screenWidgets = SplashScreen();
    } else if (setting.name == LoginScreen.name) {
      screenWidgets = LoginScreen();
    } else if (setting.name == SignInScreen.name) {
      screenWidgets = SignInScreen();
    } else if (setting.name == MainBottomNavScreen.name) {
      screenWidgets = MainBottomNavScreen();
    } else if (setting.name == ProductListScreen.name) {
      final CategoryModel category = setting.arguments as CategoryModel;
      screenWidgets = ProductListScreen(category: category);
    } else if (setting.name == ProductDetailsScreen.name) {
      final String productId = setting.arguments as String;
      screenWidgets = ProductDetailsScreen(productId: productId);
    } else if (setting.name == ProductReviewsScreen.name) {
      final String productId = setting.arguments as String;
      screenWidgets = ProductReviewsScreen(productId: productId);
    } else if (setting.name == CreateProductReviewsScreen.name) {
      final String productId = setting.arguments as String;
      screenWidgets = CreateProductReviewsScreen(productId: productId);
    } else if (setting.name == VerifyOtpScreen.name) {
      final String email = setting.arguments as String;
      screenWidgets = VerifyOtpScreen(email: email);
    } else if (setting.name == ShippingAddressScreen.name) {
      // final CategoryModel category=setting.arguments as CategoryModel;
      screenWidgets = ShippingAddressScreen();
    }

    return MaterialPageRoute(builder: (context) => screenWidgets);
  }
}
