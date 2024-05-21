import 'package:flutter/material.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view/signin_screen.dart';
import 'package:parkly/features/authentication/view/signup_screen.dart';

class AppRoutes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case RouteNames.signInScreen:
        return MaterialPageRoute(builder: (context) => const SignInScreen());
      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());

      default:
        return MaterialPageRoute(builder: (context) {
            return const Scaffold(
              body: SafeArea(
                child: Center(
                  child: Text('No route defined'),
                ),
              ),
            );
        },);
    }
  }

}