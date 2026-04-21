import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_request_model.dart';
import 'package:crafty_bay/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:crafty_bay/features/auth/ui/screen/login_screen.dart';
import 'package:crafty_bay/features/auth/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
   const VerifyOtpScreen({super.key, required this.email});

  static final String name = 'verify-otp';
   final String email;



  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _verifyOtpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VerifyOtpController _verifyOtpController =
      Get.find<VerifyOtpController>();
  bool _hasError = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                AppLogo(height: 90, width: 90),
                const SizedBox(height: 16),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Please enter OTP will send your this ${widget.email} address',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  controller: _verifyOtpTEController,
                  length: 4,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  onChanged: (value) {
                    if (_hasError && value.length == 4) {
                      setState(() {
                        _hasError = false;
                      });
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    activeColor: AppColors.themeColor,
                    // disabledColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: AppColors.themeColor.withOpacity(0.5),
                    selectedColor: Colors.white,
                    inactiveColor: _hasError
                        ? Colors.red
                        : AppColors.themeColor,
                    errorBorderColor: Colors.red,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  appContext: context,
                ),
                if (_hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Required fill up with 4 digit OTP",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 32),
                GetBuilder<VerifyOtpController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          _checkError();
                          _onTapVerify();
                        },
                        child: Text('Verify'),
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

  _onTapVerify() async {
    final VerifyOtpRequestModel model = VerifyOtpRequestModel(
      email: widget.email,
      otp: _verifyOtpTEController.text,
    );

    final isSuccess = await _verifyOtpController.verifyOtp(model);
    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.name,
        (predicate) => false,
      );
    } else {
      showSnackBarMessage(context, _verifyOtpController.errorMessage!, true);
    }
  }

  void _checkError() {
    if (_verifyOtpTEController.text.length < 4) {
      setState(() {
        _hasError = true;
      });
    } else {
      setState(() {
        _hasError = false;
      });
    }
  }
}
