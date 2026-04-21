import 'package:crafty_bay/features/cart/ui/screen/cart_screen.dart';
import 'package:crafty_bay/features/common/controller/category_list_controller.dart';
import 'package:crafty_bay/features/common/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/home_slider_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/new_product_list_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/popular_product_list_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/special_product_list_controller.dart';
import 'package:crafty_bay/features/home/ui/sceen/home_screen.dart';
import 'package:crafty_bay/features/product/ui/screen/product_category_screen.dart';
import 'package:crafty_bay/features/wish-list/ui/screen/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});
  static final String name='/mainBottomNav';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<HomeSliderController>().getHomeSliders();
      Get.find<CategoryListController>().getCategoryList();
      Get.find<PopularProductListController>().getPopularProducts();
      Get.find<SpecialProductListController>().getSpecialProducts();
      Get.find<NewProductListController>().getNewProducts();

    },);

    super.initState();
  }

  final List<Widget>_screen=[
    HomeScreen(),
    ProductCategoryScreen(),
    CartScreen(),
    WishListScreen(),


  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (navController) {
        return Scaffold(
          body: _screen[navController.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: navController.selectedIndex,
            onDestinationSelected:navController.changeIndex,
              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.category), label: 'Category'),
                NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
                NavigationDestination(icon: Icon(Icons.favorite), label: 'Wishlist')

              ]
          )
        );
      }
    );

  }
}
