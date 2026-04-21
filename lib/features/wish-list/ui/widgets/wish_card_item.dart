import 'package:crafty_bay/app/constants.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/common/controller/auth_controller.dart';
import 'package:crafty_bay/features/product/controller/add_to_cart_controller.dart';
import 'package:crafty_bay/features/wish-list/data/model/wish_list_item_model.dart';
import 'package:crafty_bay/features/wish-list/ui/controller/delete_wish_item_controller.dart';
import 'package:crafty_bay/features/wish-list/ui/controller/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishCardItem extends StatefulWidget {
  const WishCardItem({
    super.key,
    required this.wishListItem,
    required this.productId,
  });

  final WishListItemModel wishListItem;
  final String productId;

  @override
  State<WishCardItem> createState() => _WishCardItemState();
}

class _WishCardItemState extends State<WishCardItem> {
  final WishListController _wishListController = Get.find<WishListController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        children: [
          Center(
            child: Container(
              height: 110,
              width: 110,

              child: widget.wishListItem.productModel.photoUrls.isNotEmpty
                  ? Image.network(
                      widget.wishListItem.productModel.photoUrls.first,
                      fit: BoxFit.scaleDown,
                      errorBuilder: (_, __, ___) {
                        return Icon(Icons.error_outline, color: Colors.red);
                      },
                    )
                  : Center(
                      child: Icon(Icons.image_not_supported_outlined, size: 50),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getTitle(widget.wishListItem.productModel.title),
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 17,
                  ),
                ),
                Text(
                  '${Constants.takaSign}${widget.wishListItem.productModel.currentPrice}',
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      _onTapAddToCartButton();
                    },
                    child: Icon(Icons.shopping_cart_sharp),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      _onTapDeleteWishItem(context);
                    },
                    child: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(String title) {
    if (title.length > 10) {
      return '${title.substring(0, 10)}..';
    }
    return title;
  }

  Future<void> _onTapAddToCartButton() async {
    if (await Get.find<AuthController>().isUserLoggedIn()) {
      final bool result = await Get.find<AddToCartController>().addToCart(
        widget.productId,
      );
      if (!mounted) return;
      if (result) {
        showSnackBarMessage(context, 'Added to cart');
        final bool isDeleted = await Get.find<DeleteWishItemController>()
            .deleteWishItem(widget.wishListItem.id);
        if (!mounted) return;
        if (isDeleted) {
          Get.find<WishListController>().removeItem(widget.wishListItem.id);
        }
      } else {
        showSnackBarMessage(
          context,
          Get.find<AddToCartController>().errorMessage!,
        );
      }
    }
  }

  Future<void> _onTapDeleteWishItem(BuildContext context) async {
    final bool isSuccess = await Get.find<DeleteWishItemController>()
        .deleteWishItem(widget.wishListItem.id);

    if (!mounted) return;

    if (isSuccess) {
      Get.find<WishListController>().removeItem(widget.wishListItem.id);
      showSnackBarMessage(
        context,
        Get.find<DeleteWishItemController>().message,
      );
    } else {
      showSnackBarMessage(
        context,
        Get.find<DeleteWishItemController>().errorMessage!,
      );
    }
  }
}
