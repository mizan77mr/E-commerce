import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/product/controller/product_create_review_controller.dart';
import 'package:crafty_bay/features/product/controller/product_review_controller.dart';
import 'package:crafty_bay/features/product/data/model/product_create_review_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductReviewsScreen extends StatefulWidget {
  const CreateProductReviewsScreen({super.key, required this.productId});

  static final String name = 'create-reviews';
  final String productId;

  @override
  State<CreateProductReviewsScreen> createState() =>
      _CreateProductReviewsScreenState();
}

class _CreateProductReviewsScreenState
    extends State<CreateProductReviewsScreen> {
  final TextEditingController _fNameTEController = TextEditingController();
  final TextEditingController _lNameTEController = TextEditingController();
  final TextEditingController _wrNameTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProductCreateReviewController _createReviewController =
      Get.find<ProductCreateReviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Review')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _fNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Fist Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Last Name'),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Last Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _wrNameTEController,
                  textInputAction: TextInputAction.done,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Write Review',
                    contentPadding: EdgeInsets.all(12),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Review';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                GetBuilder(
                  init: _createReviewController,
                  builder: (context) {
                    return Visibility(
                      visible: _createReviewController.inProgress == false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _onTapCreateReview();
                          }
                        },
                        child: Text('Submit'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapCreateReview() async {
    final ProductCreateReviewRequestModel model =
        ProductCreateReviewRequestModel(
          product: widget.productId,
          comment: _wrNameTEController.text.trim(),
          rating: '',
          fristName: _fNameTEController.text.trim(),
          lastName: _lNameTEController.text.trim(),
        );

    final bool isSuccess = await Get.find<ProductCreateReviewController>()
        .createReview(model);

    if (isSuccess) {
      await Get.find<ProductReviewController>().getProductReview(widget.productId);
      showSnackBarMessage(context, _createReviewController.message);
      Navigator.pop(context);
    } else {
      showSnackBarMessage(context, _createReviewController.errorMessage!, true);
    }
  }

  @override
  void dispose() {
    _fNameTEController.dispose();
    _lNameTEController.dispose();
    _wrNameTEController.dispose();
    super.dispose();
  }
}
