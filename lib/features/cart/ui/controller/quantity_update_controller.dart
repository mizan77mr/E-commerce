import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network/network_client.dart';
import 'package:crafty_bay/features/cart/data/model/quantity_request_model.dart';
import 'package:get/get.dart';

class QuantityUpdateController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  late String _message;

  String? get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  String get message => _message;

  Future<bool> updateQuantity(String id, QuantityRequestModel model) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response = await Get.find<NetworkClient>().patchRequest(
      Urls.updateQuantity(id),
      body: model.toJson(),
    );
    if (response.isSuccess) {
      _message = response.responseData!['msg'];
      _errorMessage = null;
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}
