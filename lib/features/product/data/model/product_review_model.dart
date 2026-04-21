import 'package:crafty_bay/features/common/model/product_model.dart';
import 'package:crafty_bay/features/common/model/user_model.dart';

class ProductReviewModel {
  final String id;
  final String comment;
  final String createdAt;
  final ProductModel product;
  final UserModel user;

  ProductReviewModel({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.product,
    required this.user,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductReviewModel(
      id: jsonData['_id'],
      comment: jsonData['comment'],
      createdAt: jsonData['createdAt'],
      product: ProductModel.fromJson(jsonData['product']),
      user: UserModel.fromJson(jsonData['user']),
    );
  }
}
