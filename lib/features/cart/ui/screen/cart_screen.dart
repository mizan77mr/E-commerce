import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/constants.dart';
import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/Order/ui/screen/shipping_address_screen.dart';
import 'package:crafty_bay/features/cart/ui/controller/cart_list_controller.dart';
import 'package:crafty_bay/features/cart/ui/widgets/card_Item.dart';
import 'package:crafty_bay/features/common/ui/controller/main_bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartListController _cartListController = Get.find<CartListController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartListController.getCartItemList();
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
          init: _cartListController,
          builder: (_) {
            if (_cartListController.inProgress) {
              return Center(child: CenteredCircularProgressIndicator());
            }
            if (_cartListController.errorMessage != null) {
              return Center(child: Text(_cartListController.errorMessage!));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _cartListController.cartItemList.length,
                    itemBuilder: (context, index) {
                      return CardItem(
                        cartItem: _cartListController.cartItemList[index],
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                  ),
                ),
                _buildAddToCheckOut(context),
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

  Widget _buildAddToCheckOut(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.15),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Price', style: Theme.of(context).textTheme.bodyLarge),

              GetBuilder<CartListController>(
                builder: (controller) {
                  return Text(
                    '${Constants.takaSign} ${controller.totalPrice}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.themeColor,
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                _cartListController.cartItemList.isNotEmpty
                    ? Navigator.pushNamed(context, ShippingAddressScreen.name)
                    : showSnackBarMessage(context, 'Cart List is Empty!');
              },
              child: Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
