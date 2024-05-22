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

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.popAndPushNamed(context, RouteNames.selectionScreen);
      },
    );
  }

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
                const Text(
                  'Park with ease. Find your space ',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.35),
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
