import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network/network_client.dart';
import 'package:crafty_bay/features/product/data/model/product_review_model.dart';
import 'package:get/get.dart';

class ProductReviewController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<ProductReviewModel> _productReviewList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<ProductReviewModel> get productReviewList => _productReviewList;

  Future<bool> getProductReview(String id) async {
    bool _isSuccess = false;
    _inProgress = true;
    _productReviewList=[];
    update();
    NetworkResponse response = await Get.find<NetworkClient>().getRequest(
      Urls.productReviewUrl(id),
    );
    if (response.isSuccess) {
      List<ProductReviewModel> list = [];
      for (Map<String, dynamic> review
          in response.responseData!['data']['results']) {
        list.add(ProductReviewModel.fromJson(review));
      }
      _productReviewList = list;
      _isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return _isSuccess;
  }
}
