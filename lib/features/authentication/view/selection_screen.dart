import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkly/common/custom_divider.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/resources/assets/ImageAssets.dart';
import 'package:parkly/resources/colors/appColor.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(ImageAssets.parklyLogo, width: 200, height: 200),
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
                const SizedBox(height: 20.0),
                CustomButton(
                  title: 'Login with user',
                  titleTextColor: AppColors.whiteColor,
                  backgroundColor: AppColors.primaryColor,
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.signInScreen);
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  title: 'Login as Admin',
                  titleTextColor: AppColors.primaryColor,
                  backgroundColor: AppColors.whiteColor,
                  borderColor: AppColors.primaryColor,
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.adminSignInScreen);
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.2),
                  child: const CustomDivider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    required this.titleTextColor,
    required this.backgroundColor,
    required this.onTap,
    this.borderColor,
    this.isLoading = false,
    super.key,
  });
  final String title;
  final Color backgroundColor;
  final Color titleTextColor;
  final Color? borderColor;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor ?? AppColors.whiteColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: isLoading ? const Center(
            child: SpinKitFadingCircle(
              size: 20,
              color: AppColors.whiteColor,
            ),
          ): Text(
            title,
            style: TextStyle(color: titleTextColor),
          ),
        ),
      ),
    );
  }
}
