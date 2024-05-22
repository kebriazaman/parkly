import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkly/features/authentication/model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool _toggle = false;
  bool _isLoading = false;
  String _name = '';
  String _email = '';
  String _password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  User? _user;

  User? get user => _user;

  bool get isVisible => _isVisible;
  bool get isLoading => _isLoading;
  bool get toggle => _toggle;
  String get email => _email;
  String get name => _name;
  String get password => _password;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setVisibility(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  void setIconToggle(bool value) {
    _toggle = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void loginUser(GlobalKey<FormState> key) async {
    setLoading(true);
    if (key.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.trim(),
          password: password.trim(),
        );
        _user = userCredential.user;
        notifyListeners();
        setLoading(false);
      } on FirebaseAuthException catch (e) {
        setLoading(false);
        print('Error singin in: ${e.code}');
      }
    } else {
      setLoading(false);
    }
  }

  void registerUser(GlobalKey<FormState> key) async {
    setLoading(true);
    try {
      if (key.currentState!.validate()) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;
        if (user != null) {
          UserModel userModel = UserModel(uid: user.uid, email: user.email, name: user.displayName);

          await _firebaseFirestore.collection('users').doc(user.uid).set(userModel.toJson());
          _user = user;
          notifyListeners();
          setLoading(false);
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Error registering user: ${e.code}');
      setLoading(false);
    }
  }

}
