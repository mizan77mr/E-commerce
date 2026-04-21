import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/asset_path.dart';
import 'package:crafty_bay/features/common/model/product_model.dart';
import 'package:crafty_bay/features/product/ui/screen/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.name,
          arguments: productModel.id,
        );
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.themeColor.withOpacity(0.2),
              offset: Offset(0.0, 0.7),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 140,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: productModel.photoUrls.isNotEmpty
                  ? Image.network(
                      productModel.photoUrls.first,
                      fit: BoxFit.cover,
                      height: 80,
                      errorBuilder: (_, __, ___) {
                        return Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 80,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Icon(Icons.image_not_supported_outlined, size: 80),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    productModel.title,
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${productModel.currentPrice}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.themeColor,
                        ),
                      ),
                      Wrap(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          Text('4.5', style: TextStyle(color: Colors.grey)),
                        ],
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
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
