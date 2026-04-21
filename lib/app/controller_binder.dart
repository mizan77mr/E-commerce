import 'package:crafty_bay/core/services/network/network_client.dart';
import 'package:crafty_bay/features/Order/ui/controller/order_place_controller.dart';
import 'package:crafty_bay/features/auth/ui/controllers/login_controller.dart';
import 'package:crafty_bay/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:crafty_bay/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:crafty_bay/features/auth/ui/screen/login_screen.dart';
import 'package:crafty_bay/features/cart/ui/controller/cart_list_controller.dart';
import 'package:crafty_bay/features/cart/ui/controller/delete_cart_item_controller.dart';
import 'package:crafty_bay/features/cart/ui/controller/quantity_update_controller.dart';
import 'package:crafty_bay/features/common/controller/auth_controller.dart';
import 'package:crafty_bay/features/common/controller/category_list_controller.dart';
import 'package:crafty_bay/features/common/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/home_slider_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/new_product_list_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/popular_product_list_controller.dart';
import 'package:crafty_bay/features/home/ui/controller/special_product_list_controller.dart';
import 'package:crafty_bay/features/product/controller/add_to_cart_controller.dart';
import 'package:crafty_bay/features/product/controller/add_to_wish_controller.dart';
import 'package:crafty_bay/features/product/controller/product_create_review_controller.dart';
import 'package:crafty_bay/features/product/controller/product_list_by_category_controller.dart';
import 'package:crafty_bay/features/product/controller/product_review_controller.dart';
import 'package:crafty_bay/features/wish-list/ui/controller/delete_wish_item_controller.dart';
import 'package:crafty_bay/features/wish-list/ui/controller/wish_list_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class ControllerBinder extends Bindings {


  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(
      NetworkClient(
        onUnAuthorize: _unAuthorize,
        commonHeaders: () {
          return _commonHeaders();
        },
      ),
    );
    Get.put(SignUpController());
    Get.put(VerifyOtpController());
    Get.put(LoginController());
    Get.put(AuthController());

    Get.put(HomeSliderController());
    Get.put(CategoryListController());
    Get.put(PopularProductListController());
    Get.put(SpecialProductListController());
    Get.put(NewProductListController());
    Get.put(AddToCartController());
    Get.put(CartListController());
    Get.put(QuantityUpdateController());
    Get.put(DeleteCartItemController());
    Get.put(ProductReviewController());
    Get.put(ProductCreateReviewController());
    Get.put(OrderPlaceController());
    Get.put(AddToWishController());
    Get.put(WishListController());
    Get.put(DeleteWishItemController());



  }

  Future<void> _unAuthorize() async {
    await Get.find<AuthController>().clearUserData();
    Get.to(() => LoginScreen());
  }

  Map<String, String> _commonHeaders() {
    return {
      'Content-Type': 'application/json',
      'token': Get.find<AuthController>().accessToken ?? '',
    };
  }
}
