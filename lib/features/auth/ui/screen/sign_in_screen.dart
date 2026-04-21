import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/core/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_request_model.dart';
import 'package:crafty_bay/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:crafty_bay/features/auth/ui/screen/login_screen.dart';
import 'package:crafty_bay/features/auth/ui/screen/verify_otp_screen.dart';
import 'package:crafty_bay/features/auth/ui/widgets/app_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static final String name = '/signIn';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fNameTEController = TextEditingController();
  final TextEditingController _lNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shoppingAddressTEController =
      TextEditingController();
  final SignUpController _signUpController = Get.find<SignUpController>();

  bool _isTap = false;

  void _isOnTapShow() {
    _isTap = !_isTap;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 44),
                  AppLogo(height: 90, width: 90),
                  const SizedBox(height: 16),
                  Text(
                    'Register Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Please enter your details & sign up ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value!);
                      if (value.isEmpty) {
                        return 'Enter a email';
                      } else if (emailValid == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _fNameTEController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lNameTEController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Mobile can\'t be empty';
                      } else if (value.isNotEmpty) {
                        //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(value);

                        bool mobileValid = RegExp(
                          r'^(?:\+?88|0088)?01[13-9]\d{8}$',
                        ).hasMatch(value);
                        return mobileValid ? null : "Invalid mobile";
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: _isTap,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'Password',

                      suffixIcon: IconButton(
                        onPressed: _isOnTapShow,
                        icon: _isTap
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                    validator: (String? value) {
                      RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      );
                      if (value!.isEmpty) {
                        return 'Enter password';
                      } else {
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid password';
                        } else {
                          return null;
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _cityTEController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'City'),
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return 'Enter your city';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _shoppingAddressTEController,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Shopping Address',
                      contentPadding: EdgeInsets.all(12),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return 'Enter your shopping adders';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<SignUpController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapRegister,
                          child: Text('Register'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          children: [
                            TextSpan(text: 'Have already account? '),
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                color: AppColors.themeColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _onTapSignIn(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapRegister() async {
    if (_formKey.currentState!.validate()) {
      final SignUpRequestModel model = SignUpRequestModel(
        firstName: _fNameTEController.text.trim(),
        lastName: _lNameTEController.text.trim(),
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
        phone: _mobileTEController.text.trim(),
        city: _cityTEController.text.trim(),
      );

      final bool isSuccess = await _signUpController.signUp(model);
      if (isSuccess) {
        showSnackBarMessage(context, _signUpController.message);


        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VerifyOtpScreen(email: _emailTEController.text.trim()),
          ),
        );*/
        Navigator.pushNamed(
          context,
          VerifyOtpScreen.name,
          arguments: _emailTEController.text.trim(),
        );
        _textFieldClear();
      } else {
        showSnackBarMessage(context, _signUpController.errorMessage!, true);
      }
    }
  }

  void _onTapSignIn(context) {
    Navigator.pushNamed(context, LoginScreen.name);
  }

  void _textFieldClear() {
    _emailTEController.clear();
    _fNameTEController.clear();
    _lNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
    _cityTEController.clear();
    _shoppingAddressTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _fNameTEController.dispose();
    _lNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    _cityTEController.dispose();
    _shoppingAddressTEController.dispose();
    super.dispose();
  }
}
