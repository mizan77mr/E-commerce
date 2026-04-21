import 'package:crafty_bay/features/Order/data/model/shipping_address_request_model.dart';

class OrderPlaceRequestModel {
  final String paymentMethod;
  final ShippingAddressRequestModel shippingAddress;
  final String redirectUrl;

  OrderPlaceRequestModel({
    required this.paymentMethod,
    required this.shippingAddress,
    required this.redirectUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "payment_method": paymentMethod,
      "shipping_address": shippingAddress.toJson(),
      "redirect_url": redirectUrl,
    };
  }
}
