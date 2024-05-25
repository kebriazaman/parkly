import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parkly/config/routes/app_routes.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view_model/auth_provider.dart';
import 'package:parkly/features/book_parking/view_model/main_menu_provider.dart';
import 'package:parkly/features/main_menu/view_model/admin_provider.dart';
import 'package:parkly/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => MainMenuProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
