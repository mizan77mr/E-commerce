import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/asset_path.dart';
import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/features/common/controller/category_list_controller.dart';
import 'package:crafty_bay/features/common/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay/features/common/ui/widgets/product_card.dart';
import 'package:crafty_bay/features/home/ui/controller/home_slider_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/new_product_list_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/popular_product_list_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/special_product_list_controller.dart';
import 'package:crafty_bay/features/home/ui/widgets/app_bar_icon.dart';
import 'package:crafty_bay/features/common/ui/widgets/product_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/home_carousel_slider.dart';
import '../widgets/product_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(AssetPath.navLogo),
        actions: [
          AppBarIcon(onTap: () {}, iconData: Icons.person),
          AppBarIcon(onTap: () {}, iconData: Icons.call),
          AppBarIcon(onTap: () {}, iconData: Icons.notification_add),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProductSearch(),
              const SizedBox(height: 16),
              GetBuilder<HomeSliderController>(
                builder: (sliderController) {
                  if (sliderController.inProgress) {
                    return SizedBox(
                      height: 192,
                      child: CenteredCircularProgressIndicator(),
                    );
                  }

                  return HomeCarouselSlider(
                    sliders: sliderController.sliderModelList,
                  );
                },
              ),
              _buildSectionHeader(
                title: 'Categories',
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().moveToCategory();
                },
              ),
              _getBuildCategory(),
              _buildSectionHeader(title: 'Popular', onTapSeeAll: () {}),
              _getBuildPopular(),
              _buildSectionHeader(title: 'Special', onTapSeeAll: () {}),
              _getBuildSpecial(),
              _buildSectionHeader(title: 'New', onTapSeeAll: () {}),
              _getBuildNew(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onTapSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        TextButton(onPressed: onTapSeeAll, child: Text('See All')),
      ],
    );
  }

  Widget _getBuildCategory() {
    return SizedBox(
      height: 100,
      child: GetBuilder<CategoryListController>(
        builder: (controller) {
          if (controller.initialLoadingInProgress) {
            return CenteredCircularProgressIndicator();
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.homeCategoryListItemLength,
            itemBuilder: (context, index) {
              return ProductCategoryItem(
                categoryModel: controller.categoryModelList[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 8),
          );
        },
      ),
    );
  }

  Widget _getBuildPopular() {
    return GetBuilder<PopularProductListController>(
      builder: (popularProductController) {
        return Visibility(
          visible: popularProductController.inProgress == false,
          replacement: CenteredCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: popularProductController.productModelList
                  .map((product) => ProductCard(productModel: product))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _getBuildSpecial() {
    return GetBuilder<SpecialProductListController>(
      builder: (specialProductController) {
        return Visibility(
          visible: specialProductController.inProgress == false,
          replacement: CenteredCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: specialProductController.productModelList
                  .map((product) => ProductCard(productModel: product))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _getBuildNew() {
    return GetBuilder<NewProductListController>(
      builder: (newProductController) {
        return Visibility(
          visible: newProductController.inProgress == false,
          replacement: CenteredCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: newProductController.productModelList
                  .map((product) => ProductCard(productModel: product))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
