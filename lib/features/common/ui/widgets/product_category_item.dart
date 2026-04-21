import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/common/model/category_model.dart';
import 'package:crafty_bay/features/product/ui/screen/product_list_screen.dart';
import 'package:flutter/material.dart';

class ProductCategoryItem extends StatelessWidget {
  const ProductCategoryItem({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: categoryModel,
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(categoryModel.iconUrl, height: 32, width: 32,errorBuilder: (_,__,___){
              return Center(child: Icon(Icons.error_outline,color: Colors.red,),);

            },),
          ),
          const SizedBox(height: 4),
          Text(
            _getTitle(categoryModel.title),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.themeColor),
          ),
        ],
      ),
    );
  }

  String _getTitle(String title) {
    if (title.length > 8) {
      return '${title.substring(0, 7)}..';
    }
    return title;
  }
}
