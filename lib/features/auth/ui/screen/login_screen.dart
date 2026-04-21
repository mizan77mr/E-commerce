import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/core/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/auth/data/models/log_in_request_model.dart';
import 'package:crafty_bay/features/auth/ui/controllers/login_controller.dart';
import 'package:crafty_bay/features/auth/ui/screen/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/ui/widgets/app_logo.dart';
import 'package:crafty_bay/features/common/controller/auth_controller.dart';
import 'package:crafty_bay/features/common/ui/screen/main_bottom_nav_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static final String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final LoginController _loginController = Get.find<LoginController>();
  bool _isTap = false;

  void _isOnTapShow() {
    _isTap = !_isTap;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Please Enter your Email & Password',
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
                  controller: _passwordTEController,
                  obscureText: _isTap,
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
                      return 'Please enter password';
                    } else {
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password';
                      } else {
                        return null;
                      }
                    }
                  },
                ),

                const SizedBox(height: 16),
                ElevatedButton(onPressed: _onTapLogIn, child: Text('Log in')),

                const SizedBox(height: 24),
                Text(
                  'Forget Password?',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        children: [
                          TextSpan(text: 'Don\'t have a account?  '),
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                              color: AppColors.themeColor,
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
    );
  }

  Future<void> _onTapLogIn() async {
    if (_formKey.currentState!.validate()) {
       LogInRequestModel model = LogInRequestModel(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
      );

      final bool isSuccess = await Get.find<LoginController>().logIn(model);
      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainBottomNavScreen.name,
          (predicate) => false,
        );
      } else {
        showSnackBarMessage(context, _loginController.errorMessage!, true);
      }
    }
  }

  void _onTapSignIn(context) {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
