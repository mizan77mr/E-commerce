import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/constants.dart';
import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/auth/ui/screen/login_screen.dart';
import 'package:crafty_bay/features/common/controller/auth_controller.dart';
import 'package:crafty_bay/features/common/model/product_model.dart';
import 'package:crafty_bay/features/product/controller/add_to_cart_controller.dart';
import 'package:crafty_bay/features/product/controller/add_to_wish_controller.dart';
import 'package:crafty_bay/features/product/controller/product_details_controller.dart';
import 'package:crafty_bay/features/product/data/model/product_details_model.dart';
import 'package:crafty_bay/features/product/ui/screen/product_reviews_screen.dart';
import 'package:crafty_bay/features/product/ui/widgets/increment_decrement_button.dart';
import 'package:crafty_bay/features/product/ui/widgets/product_color_picker.dart';
import 'package:crafty_bay/features/product/ui/widgets/product_image_slider.dart';
import 'package:crafty_bay/features/product/ui/widgets/product_size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static final String name = '/product-details';
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController =
      ProductDetailsController();
  final AddToCartController _addToCartController =
      Get.find<AddToCartController>();

  final AddToWishController _addToWishController =
      Get.find<AddToWishController>();

  @override
  void initState() {
    _productDetailsController.getProductDetails(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (_) {
          if (_productDetailsController.inProgress) {
            return CenteredCircularProgressIndicator();
          }
          if (_productDetailsController.errorMessage != null) {
            return Center(child: Text(_productDetailsController.errorMessage!));
          }
          final ProductDetailsModel product =
              _productDetailsController.productDetails;
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ProductImageSlider(images: product.photoUrls),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.title,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.6,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  IncrementDecrementButton(
                                    onChange: (int value) {},
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Wrap(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        ProductReviewsScreen.name,
                                        arguments: widget.productId,
                                      );
                                    },
                                    child: Text('Reviews'),
                                  ),

                                  Card(
                                    color: AppColors.themeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: product.colors.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Color',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ProductColorPicker(
                                      color: product.colors,
                                      onSelected: (String) {},
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Visibility(
                                visible: product.sizes.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Size',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ProductSizePicker(
                                      Size: product.sizes,
                                      onSelected: (String) {},
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.description,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildAddToCart(context),
            ],
          );
        },
      ),
    );
  }

  Widget buildAddToCart(BuildContext context) {
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

              GetBuilder<ProductDetailsController>(
                builder: (productDetailController) {
                  return Text(
                    '${Constants.takaSign}${productDetailController.productDetails.currentPrice}',
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
                _showDialogue();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Add to'),
                  Icon(Icons.keyboard_arrow_up_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add to your Choose', style: TextStyle(fontSize: 20)),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.teal),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: 110,
              child: GetBuilder(
                init: _addToWishController,
                builder: (_) {
                  return Visibility(
                    visible: _addToWishController.inProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed:(){

                        _onTapAddToWishButton();
                        Navigator.pop(context);
                      } ,
                      child: Text(
                        'Add to Wish',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: 100,
              child: GetBuilder(
                init: _addToCartController,
                builder: (_) {
                  return Visibility(
                    visible: _addToCartController.inProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        _onTapAddToCartButton();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onTapAddToCartButton() async {
    if (await Get.find<AuthController>().isUserLoggedIn()) {
      final bool result = await _addToCartController.addToCart(
        widget.productId,
      );
      if (result) {
        showSnackBarMessage(context, 'Added to cart');
      } else {
        showSnackBarMessage(context, _addToCartController.errorMessage!);
      }
    } else {
      Navigator.pushNamed(context, LoginScreen.name);
    }
  }

  Future<void> _onTapAddToWishButton() async {
    if (await Get.find<AuthController>().isUserLoggedIn()) {
      final bool result = await _addToWishController.addToWish(
        widget.productId,
      );
      if (result) {
        showSnackBarMessage(context, 'Added to wish');
      } else {
        showSnackBarMessage(context, _addToWishController.errorMessage!);
      }
    } else {
      Navigator.pushNamed(context, LoginScreen.name);
    }
  }
}
