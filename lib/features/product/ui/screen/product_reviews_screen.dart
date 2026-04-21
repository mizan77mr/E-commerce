import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/features/product/controller/product_review_controller.dart';
import 'package:crafty_bay/features/product/ui/screen/create_product_reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key, required this.productId});

  static final String name = 'review-screen';
  final String productId;

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  final ProductReviewController _reviewController =
      Get.find<ProductReviewController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reviewController.getProductReview(widget.productId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      body: GetBuilder<ProductReviewController>(
        builder: (_) {
          if (_reviewController.inProgress) {
            return Center(child: CenteredCircularProgressIndicator());
          }
          if (_reviewController.errorMessage != null) {
            return Center(child: Text(_reviewController.errorMessage!));
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    itemCount: _reviewController.productReviewList.length,
                    itemBuilder: (context, index) {
                      final review=_reviewController.productReviewList[index];

                      return Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: AppColors.themeColor
                                    .withOpacity(0.5),
                                child: Icon(Icons.person),
                              ),
                              const SizedBox(width: 8),
                              Text('${review.user.firstName} ${review.user.lastName}'),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              review.comment
                               ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder(
                        init: _reviewController,
                        builder: (_) {
                          return Text(
                            '${_reviewController.productReviewList.length} (Reviews)',
                            style: Theme.of(context).textTheme.bodyLarge,
                          );
                        }
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            CreateProductReviewsScreen.name,
                            arguments: widget.productId,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
