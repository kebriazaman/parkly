import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool _toggle = false;
  String _namePhoneNumber = '';
  String _password = '';




  bool get isVisible => _isVisible;
  bool get toggle => _toggle;
  String get namePhoneNumber => _namePhoneNumber;
  String get password => _password;

  void setVisibility(bool value) {
    _isVisible = value;
    notifyListeners();
  }
  void setIconToggle(bool value) {
    _toggle = value;
    notifyListeners();
  }

  void setNamePhoneNumber(String value) {
    _namePhoneNumber = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void loginUser(GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {

    }
  }

}