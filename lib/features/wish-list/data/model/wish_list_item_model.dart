
import 'package:crafty_bay/features/common/model/product_model.dart';

class WishListItemModel {
  final String id;
  final ProductModel productModel;
  final String? color;
  final String? size;

  WishListItemModel({
    required this.id,
    required this.productModel,
    required this.color,
    required this.size,
  });

  factory WishListItemModel.fromJson(Map<String, dynamic> jsonData) {
    return WishListItemModel(
      id: jsonData['_id'],
      productModel: ProductModel.fromJson(jsonData['product']),
      color: jsonData['color'],
      size: jsonData['size'],
    );
  }
}