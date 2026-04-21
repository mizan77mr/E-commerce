import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/constants.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/cart/data/model/cart_list_model.dart';
import 'package:crafty_bay/features/cart/data/model/quantity_request_model.dart';
import 'package:crafty_bay/features/cart/ui/controller/cart_list_controller.dart';
import 'package:crafty_bay/features/cart/ui/controller/delete_cart_item_controller.dart';
import 'package:crafty_bay/features/cart/ui/controller/quantity_update_controller.dart';
import 'package:crafty_bay/features/cart/ui/widgets/quantity_increment_decrement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.white,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            padding: EdgeInsets.all(8),
            child: cartItem.productModel.photoUrls.isNotEmpty
                ? Image.network(
                    cartItem.productModel.photoUrls.first,
                    fit: BoxFit.scaleDown,
                    errorBuilder: (_, __, ___) {
                      return Center(
                        child: Icon(Icons.error_outline, color: Colors.red),
                      );
                    },
                  )
                : Center(child: Icon(Icons.image_not_supported_outlined)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 4,
                right: 12,
                bottom: 16,
                top: 4,
              ),
              child: Column(
                spacing: 6,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.productModel.title,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                                color: Colors.black54,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              'Color: ${cartItem.color}  Size: ${cartItem.size}',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _onTapDeleteCartItem(context);
                        },
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.black45,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Constants.takaSign}${cartItem.productModel.currentPrice}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.themeColor,
                        ),
                      ),
                      QuantityIncrementDecrement(
                        initialValue: cartItem.quantity,
                        onChange: (int value) async {
                          final controller =
                              Get.find<QuantityUpdateController>();
                          final model = QuantityRequestModel(quantity: value);
                          bool success = await controller.updateQuantity(
                            cartItem.id.toString(),
                            model,
                          );
                          if (success) {
                            Get.find<CartListController>().updateQuantity(
                              cartItem.id,
                              value,
                            );
                          } else {
                            showSnackBarMessage(
                              context,
                              'Quantity added Failed!',
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapDeleteCartItem(BuildContext context) async {
    final bool isSuccess = await Get.find<DeleteCartItemController>()
        .deleteCartItem(cartItem.id);

    if (isSuccess) {
      Get.find<CartListController>().removeItem(cartItem.id);
      showSnackBarMessage(
        context,
        Get.find<DeleteCartItemController>().message,
      );
    } else {
      showSnackBarMessage(
        context,
        Get.find<DeleteCartItemController>().errorMessage!,
      );
    }
  }
}
