import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkly/common/custom_divider.dart';
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
                CustomButton(title: 'Login with user',
                titleTextColor: AppColors.primaryColor,),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
                const CustomDivider(),
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
    super.key,
  });
  final String title;
  final Color backgroundColor;
  final Color titleTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(title),
        ),
      ),
    );
  }
}
