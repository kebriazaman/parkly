import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parkly/common/custom_divider.dart';
import 'package:parkly/common/decorations.dart';
import 'package:parkly/config/routes/app_routes.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:provider/provider.dart';

import '../../../resources/assets/ImageAssets.dart';
import '../../../resources/colors/appColor.dart';
import '../view_model/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(ImageAssets.parklyLogo, width: 180, height: 180),
                const Text.rich(
                  TextSpan(
                    text: 'Welcome to the\n',
                    children: [
                      TextSpan(
                        text: 'Parkly App',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 15.0),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: emailPhoneController,
                          cursorColor: Colors.black,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: TextInputDecoration,
                          validator: (value) => value!.isEmpty ? 'Please enter email or phone number' : null,
                          onChanged: (value) {
                            context.read<AuthProvider>().setNamePhoneNumber(value);
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Consumer<AuthProvider>(builder: (context, provider, child) {
                          return TextFormField(
                            controller: passwordController,
                            cursorColor: Colors.black,
                            obscureText: provider.toggle,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => value!.length < 8 ? 'Password must be 8 characters long' : null,
                            onChanged: (value) {
                              context.read<AuthProvider>().setPassword(value);
                            },
                            decoration: TextInputDecoration.copyWith(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  provider.setIconToggle(!provider.toggle);
                                },
                                icon: provider.toggle ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              ),
                            ),
                          );
                        },),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.forgotPasswordScreen);
                          },
                          child: const Text(
                            'Forgot Password?',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        CustomButton(
                          title: 'Login',
                          titleTextColor: AppColors.whiteColor,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {
                            context.read<AuthProvider>().loginUser(_formKey);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text('Or'),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SvgPicture.asset(ImageAssets.googleIcon),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CustomButton(
                                  title: 'Google',
                                  titleTextColor: AppColors.primaryColor,
                                  backgroundColor: AppColors.whiteColor,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: SvgPicture.asset(ImageAssets.facebookIcon, color: Colors.black,
                                height: 25,),
                              ),
                              const SizedBox(width: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: CustomButton(
                                  title: 'Facebook',
                                  titleTextColor: Colors.black,
                                  backgroundColor: AppColors.whiteColor,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account?',
                    children: [
                      TextSpan(
                        text: '\t\tSignup',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, RouteNames.signUpScreen);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                const CustomDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
