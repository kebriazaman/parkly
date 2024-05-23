import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/view_model/auth_provider.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () async {
          await Provider.of<AuthProvider>(context, listen: false).logoutUser();
          Navigator.pop(context);

        }, icon: Icon(Icons.logout),),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Welcome User'),
        ),
      ),
    );
  }
}
