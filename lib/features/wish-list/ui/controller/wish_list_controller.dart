import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network/network_client.dart';
import 'package:crafty_bay/features/wish-list/data/model/wish_list_item_model.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<WishListItemModel> _wishList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<WishListItemModel> get wishList => _wishList;

  Future<bool> getWishList() async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response = await Get.find<NetworkClient>().getRequest(
      Urls.getWishListUrl,
    );
    if (response.isSuccess) {
      List<WishListItemModel> list = [];
      for (Map<String, dynamic> json
          in response.responseData!['data']['results']) {
        list.add(WishListItemModel.fromJson(json));
      }
      _wishList = list;
      _isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
  void removeItem(dynamic id){
    _wishList.removeWhere((item)=>item.id==id);
    update();
  }
}
