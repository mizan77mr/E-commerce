import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network/network_client.dart';
import 'package:crafty_bay/features/auth/data/models/log_in_request_model.dart';
import 'package:crafty_bay/features/common/controller/auth_controller.dart';
import 'package:crafty_bay/features/common/model/user_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {


  bool _inProgress = false;
  String? _errorMessage;
  late String _message;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  String get message => _message;

  Future<bool> logIn(LogInRequestModel model) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkClient>()
        .postRequest(Urls.loginUrl, body: model.toJson());
    if (response.isSuccess) {
      await Get.find<AuthController>().saveUserData(
          response.responseData!['data']['token'].toString(),
          UserModel.fromJson(response.responseData!['data']['user']));
      _message = response.responseData!['msg'];
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}




