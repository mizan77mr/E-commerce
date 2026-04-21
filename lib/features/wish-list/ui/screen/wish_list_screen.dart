import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/features/common/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay/features/wish-list/ui/controller/wish_list_controller.dart';
import 'package:crafty_bay/features/wish-list/ui/widgets/wish_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final WishListController _wishListController = Get.find<WishListController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _wishListController.getWishList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _backToHome(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
            onPressed: _backToHome,
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder(
          init: _wishListController,
          builder: (_) {
            if (_wishListController.inProgress) {
              return Center(child: CenteredCircularProgressIndicator());
            }
            if (_wishListController.errorMessage != null) {
              return Center(child: Text(_wishListController.errorMessage!));
            }
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: _wishListController.wishList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 10
                    ),
                    itemBuilder: (context,index){
                      final wishProduct=_wishListController.wishList[index];
                      return WishCardItem(wishListItem:wishProduct , productId:wishProduct.productModel.id,);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _backToHome() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
