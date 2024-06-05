import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkly/features/authentication/model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool _toggle = false;
  bool _isLoading = false;
  bool _isAdmin = false;
  String _name = '';
  String _email = '';
  String _password = '';
  String _message = '';
  String? _userName;
  final List<String> _otpDigits = List.generate(6, (index) => '');



  String getOTP() {
    return _otpDigits.join('');
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  User? _user;

  User? get user => _user;

  String? get userName => _userName;
  bool get isVisible => _isVisible;
  bool get isLoading => _isLoading;
  bool get isAdmin => _isAdmin;
  bool get toggle => _toggle;
  String get email => _email;
  String get name => _name;
  String get password => _password;
  String get message => _message;

  List<String> get otpDigits => _otpDigits;

  String extractUsername(String email) {
    if (email.contains('@')) {
      print(email.split('@'[0]));
      return email.split('@')[0];
    }
    return '';
  }

  void setUserName(String v) {
    _userName = v;
    notifyListeners();
  }

  void setCheckboxValue(bool value) {
    _isAdmin = value;
    notifyListeners();
  }


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

  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }

  void updateOTPDigit(int index, String digit) {
    _otpDigits[index] = digit;
    notifyListeners();
  }


  Future<void> loginUser(GlobalKey<FormState> key) async {
    setLoading(true);
    if (key.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.trim(),
          password: password.trim(),
        );

        _user = userCredential.user;

        notifyListeners();
        _message = 'Successfully signed in.';
        notifyListeners();
        setLoading(false);
      } on FirebaseAuthException catch (e) {
        setLoading(false);
        print('Error singin in: ${e.code}');
        _message = e.code;
      }
    } else {
      setLoading(false);
    }
  }



  Future<void> loginAsAdmin(GlobalKey<FormState> key) async {
    setLoading(true);
    if (key.currentState!.validate()) {
      try {

        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.trim(),
          password: password.trim(),
        );

        _user = userCredential.user;
        _userName = extractUsername(_user!.email.toString());
        DocumentSnapshot userDoc = await _firebaseFirestore.collection('users').doc(userCredential.user!.uid).get();
        if (userDoc.exists) {
          bool isAdmin = (userDoc.data() as Map<String, dynamic>?)?['isAdmin'] ?? false;
          if (isAdmin) {
            _isAdmin = isAdmin;
            _user = userCredential.user;
            _message = 'Successfully signed in.';
          } else {
            _isAdmin = isAdmin;
            _message = 'Successfully signed in.';
            _user = userCredential.user;
          }
        } else {
          _message = 'User data not found';
        }

        notifyListeners();
        setLoading(false);
      } on FirebaseAuthException catch (e) {
        setLoading(false);
        print(_user);
        print('Error singin in: ${e.code}');

        _message = e.code;
      }
    } else {
      setLoading(false);
    }
  }

  Future<void> registerUser(GlobalKey<FormState> key) async {
    setLoading(true);
    try {
      if (key.currentState!.validate()) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;
        if (user != null) {

          var queryUser = await _firebaseFirestore.collection('users')
                                                  .where('uid', isEqualTo: user.uid)
                                                  .get();
          if (queryUser.docs.isEmpty) {
            UserModel userModel = UserModel(uid: user.uid, email: user.email, name: _name, isAdmin: isAdmin);
            await _firebaseFirestore.collection('users').doc(user.uid).set(userModel.toJson());
            _user = user;
            notifyListeners();
            setLoading(false);

          }

        }
        setLoading(false);
      }
    } on FirebaseAuthException catch (e) {
      _message = e.code;
      setLoading(false);
    }
  }

  Future<void> verifyEmail(GlobalKey<FormState> key, String email) async {
    if (key.currentState!.validate()) {
      setLoading(true);
      try {
        await _auth.sendPasswordResetEmail(email: email);
        _message = 'We have sent you email. Please check and provide otp';
        setLoading(false);
      } on FirebaseAuthException catch (e) {
        _message = e.code;
        print(e.code);
        setLoading(false);
      }
    }

  }

  void clearData() {
    _email = '';
    _password = '';
  }




  Future<void> logoutUser() async => await _auth.signOut();


}
