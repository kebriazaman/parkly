import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkly/config/routes/app_routes.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/resources/assets/ImageAssets.dart';
import 'package:parkly/resources/colors/appColor.dart';

import '../../../common/custom_divider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 3), () {
  //     Navigator.popAndPushNamed(context, RouteNames.selectionScreen);
  //   },);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(ImageAssets.parklyLogo, width: 200, height: 200),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.35),
              const CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }
}

