import 'package:flutter/material.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view/admin_signin_screen.dart';
import 'package:parkly/features/authentication/view/forgot_password_screen.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:parkly/features/authentication/view/signin_screen.dart';
import 'package:parkly/features/authentication/view/signup_screen.dart';
import 'package:parkly/features/authentication/view/splash_screen.dart';
import 'package:parkly/features/main_menu/view/admin_screen.dart';
import 'package:parkly/features/main_menu/view/details_screen.dart';
import 'package:parkly/features/main_menu/view/main_menu_screen.dart';

class AppRoutes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case RouteNames.signInScreen:
        return MaterialPageRoute(builder: (context) => const SignInScreen());
      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.selectionScreen:
        return MaterialPageRoute(builder: (context) => const SelectionScreen());
      case RouteNames.adminSignInScreen:
        return MaterialPageRoute(builder: (context) => const AdminSignInScreen());
      case RouteNames.adminScreen:
        return MaterialPageRoute(builder: (context) => const AdminScreen());
      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
      case RouteNames.detailsScreen:
        return MaterialPageRoute(builder: (context) => DetailsScreen());
     case RouteNames.mainMenuScreen:
        return MaterialPageRoute(builder: (context) => const MainMenuScreen());

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