import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(ImageAssets.parklyLogo,
                      width: MediaQuery.sizeOf(context).width * 0.5, height: MediaQuery.sizeOf(context).width * 0.5),
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
                  const Text(
                    'Login',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 15.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          cursorColor: Colors.black,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: TextInputDecoration,
                          validator: (value) => value!.isEmpty ? 'Please enter valid email' : null,
                          onChanged: (value) {
                            context.read<AuthProvider>().setEmail(value);
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Consumer<AuthProvider>(
                          builder: (context, provider, child) {
                            return TextFormField(
                              cursorColor: Colors.black,
                              obscureText: provider.toggle,
                              textInputAction: TextInputAction.done,
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
                          },
                        ),
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
                        Consumer<AuthProvider>(
                          builder: (context, provider, child) {
                            return CustomButton(
                              title: 'Login',
                              titleTextColor: AppColors.whiteColor,
                              backgroundColor: AppColors.primaryColor,
                              isLoading: provider.isLoading,
                              onTap: () async {
                                await provider.loginAsAdmin(_formKey);
                                if (provider.isAdmin && provider.user != null) {
                                  Navigator.pushReplacementNamed(context, RouteNames.adminScreen);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(provider.message)),
                                  );
                                } else if (provider.isAdmin == false && provider.user != null) {
                                  Navigator.pushReplacementNamed(context, RouteNames.mainMenuScreen);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(provider.message)),
                                  );
                                }

                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 10.0),
                  // const Text(
                  //   'Or',
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 10.0),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             border: Border.all(color: AppColors.primaryColor),
                  //           ),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 8.0),
                  //                 child: SvgPicture.asset(ImageAssets.googleIcon),
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(right: 8.0),
                  //                 child: CustomButton(
                  //                   title: 'Google',
                  //                   titleTextColor: AppColors.primaryColor,
                  //                   backgroundColor: AppColors.whiteColor,
                  //                   onTap: () {},
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(width: 20.0),
                  //       Expanded(
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.black),
                  //           ),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 16.0),
                  //                 child: SvgPicture.asset(
                  //                   ImageAssets.facebookIcon,
                  //                   color: Colors.black,
                  //                   height: 25,
                  //                 ),
                  //               ),
                  //               const SizedBox(width: 10.0),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(right: 16.0),
                  //                 child: CustomButton(
                  //                   title: 'Facebook',
                  //                   titleTextColor: Colors.black,
                  //                   backgroundColor: AppColors.whiteColor,
                  //                   onTap: () {},
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.2),
                    child: const CustomDivider(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
