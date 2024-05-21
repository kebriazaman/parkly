import 'package:flutter/material.dart';

import '../resources/colors/appColor.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 3,
        width: MediaQuery.sizeOf(context).width * 0.8,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
