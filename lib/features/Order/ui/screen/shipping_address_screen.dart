import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/Order/data/model/order_place_request_model.dart';
import 'package:crafty_bay/features/Order/data/model/shipping_address_request_model.dart';
import 'package:crafty_bay/features/Order/ui/controller/order_place_controller.dart';
import 'package:crafty_bay/features/cart/ui/controller/cart_list_controller.dart';
import 'package:crafty_bay/features/common/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key,});

  static final String name = 'shipping-address';
  // final CategoryModel category;

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final TextEditingController _fullNameTEController = TextEditingController();
  final TextEditingController _adTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _pCodeTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Address'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 42),
                TextFormField(
                  controller: _fullNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Full Name'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'full name required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8),
                TextFormField(
                  controller: _adTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Address'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return ' address required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cityTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'City'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'city required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _pCodeTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Postal Code'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'postal code required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneTEController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Phone'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'phone can\'t be empty';
                    } else if (value.isNotEmpty) {
                      //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(value);

                      bool mobileValid = RegExp(
                        r'^(?:\+?88|0088)?01[13-9]\d{8}$',
                      ).hasMatch(value);
                      return mobileValid ? null : "Invalid mobile";
                    }
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _onTapToOrderPlace();
                    }
                  },
                  child: GetBuilder<OrderPlaceController>(
                    builder: (controller) {
                      return Visibility(
                          visible: controller.inProgress==false,
                          replacement: CenteredCircularProgressIndicator(),
                          child: Text('Place Order'));
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapToOrderPlace() async {
    final OrderPlaceRequestModel model = OrderPlaceRequestModel(
      paymentMethod: 'ssl',
      shippingAddress: ShippingAddressRequestModel(
        fullName: _fullNameTEController.text.trim(),
        address: _adTEController.text.trim(),
        city: _cityTEController.text.trim(),
        postalCode: _pCodeTEController.text.trim(),
        phone: _phoneTEController.text.trim(),
      ),
      redirectUrl: 'https://jsonplaceholder.typicode.com/posts',
    );

    final bool isSuccess = await Get.find<OrderPlaceController>().getOrder(
      model,
    );

    if (isSuccess) {
      _paymentGatewayIntegration();

    } else {
      showSnackBarMessage(
        context,
        Get.find<OrderPlaceController>().errorMessage!,
        true,
      );
    }
  }

  void _paymentGatewayIntegration() async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: "visa,master,bkash,Nagad",
        currency: SSLCurrencyType.BDT,
        product_category: 'ffff',
        sdkType: SSLCSdkType.TESTBOX,
        store_id: 'devel6877e39ba31c5',
        store_passwd: "devel6877e39ba31c5@ssl",
        total_amount: double.parse(
          '${Get.find<CartListController>().totalPrice}',
        ),
        tran_id: 'tran-id${DateTime.now().millisecondsSinceEpoch}',
      ),
    );

    final response = await sslcommerz.payNow();

    if (response.status == 'VALID') {
      showSnackBarMessage(context, 'Payment Successful');
      Navigator.pop(context);
    } else if (response.status == 'Closed') {
      print('Payment closed');
    } else {
      showSnackBarMessage(context, 'Payment Flied');
    }
  }

  @override
  void dispose() {
    _fullNameTEController.dispose();
    _adTEController.dispose();
    _cityTEController.dispose();
    _pCodeTEController.dispose();
    _phoneTEController.dispose();
    super.dispose();
  }
}
