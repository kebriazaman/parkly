import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_divider.dart';
import '../../../common/decorations.dart';
import '../../../config/routes/route_names.dart';
import '../../../resources/assets/ImageAssets.dart';
import '../../../resources/colors/appColor.dart';
import '../view_model/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
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
                  SvgPicture.asset(ImageAssets.parklyLogo, width: MediaQuery.sizeOf(context).width * 0.5, height: MediaQuery.sizeOf(context).width * 0.5),
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
                    'Register',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 26),
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
                          decoration: TextInputDecoration.copyWith(
                            labelText: 'Name'
                          ),
                          validator: (value) => value!.isEmpty ? 'Please enter email or phone number' : null,
                          onChanged: (value) {
                            context.read<AuthProvider>().setName(value);
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          cursorColor: Colors.black,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: TextInputDecoration.copyWith(
                            labelText: 'Email'
                          ),
                          validator: (value) => value!.isEmpty ? 'Please enter email or phone number' : null,
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
                        const SizedBox(height: 30.0),
                        Consumer<AuthProvider>(
                          builder: (context, provider, child) {
                            return CustomButton(
                              title: 'Register',
                              titleTextColor: AppColors.whiteColor,
                              backgroundColor: AppColors.primaryColor,
                              isLoading: provider.isLoading,
                              onTap: () {
                                provider.registerUser(_formKey);
                                if (provider.user != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration Successful!')));
                                  Navigator.pushNamed(context, RouteNames.signInScreen);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.errorMessage)));
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account?',
                      children: [
                        TextSpan(
                          text: '\t\tSign In',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, RouteNames.signInScreen);
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
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
