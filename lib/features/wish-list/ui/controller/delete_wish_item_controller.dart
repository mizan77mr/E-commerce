import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network/network_client.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DeleteWishItemController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  late String _message;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  String get message => _message;

  Future<bool> deleteWishItem(String id) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response = await Get.find<NetworkClient>().deleteRequest(
      Urls.deleteWishItem(id),
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