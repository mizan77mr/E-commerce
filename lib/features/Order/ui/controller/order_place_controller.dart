import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network/network_client.dart';
import 'package:crafty_bay/features/Order/data/model/order_place_request_model.dart';
import 'package:get/get.dart';

class OrderPlaceController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  late String _message;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  String get message => _message;

  Future<bool> getOrder(OrderPlaceRequestModel model) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response = await Get.find<NetworkClient>().postRequest(
      Urls.orderPlaceUrl,
      body: model.toJson(),
    );
    if (response.isSuccess) {
      _message = response.responseData!['msg'];
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
