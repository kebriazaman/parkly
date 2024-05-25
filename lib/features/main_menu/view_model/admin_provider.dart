import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _gettingImages = false;
  String _location = '';
  String _message = '';
  String _phoneNumber = '';
  double _lat = 0.0;
  double _lng = 0.0;

  String get location => _location;
  String get phoneNumber => _phoneNumber;

  double get lat => _lat;
  double get lng => _lng;
  String get message => _message;

  bool get isLoading => _isLoading;
  bool get gettingImages => _gettingImages;

  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = <XFile>[];
  List<String> urls = <String>[];

  void setGettingImagesValue(bool v) {
    _gettingImages = v;
    notifyListeners();
  }

  void setLoading(bool v) {
    _isLoading =v;
    notifyListeners();
  }

  void setMessage(String v) {
    _message = v;
    notifyListeners();
  }

  void setLat(double v) {
    _lat = v;
    notifyListeners();
  }

  void setLng(double v) {
    _lng = v;
    notifyListeners();
  }

  void setLocation(String v) {
    _location = v;
    notifyListeners();
  }

  void setPhonenumber(String v) {
    _phoneNumber = v;
    notifyListeners();
  }



  void getImagesFromGallery() async {
    urls.clear();
    notifyListeners();
    setGettingImagesValue(true);
    final List<XFile> files = await _picker.pickMultiImage();
    if (files.isNotEmpty) {
      selectedImages = files;
      for (XFile image in selectedImages) {
        String downloadUrl = await uploadImageToFirebase(image);
        urls.add(downloadUrl);
      }
      notifyListeners();
    }
    setGettingImagesValue(false);
  }



  Future<String> uploadImageToFirebase(XFile image) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}_${image.name}');
    UploadTask uploadTask = storageReference.putFile(File(image.path));
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<geocoding.Location?> convertAddressToCoordinates() async {
    List<geocoding.Location> address = await geocoding.locationFromAddress(_location);
    if (address.isNotEmpty) {
      return address[0];
    }
    return null;
  }

  Future<void> saveData(GlobalKey<FormState> key, String? userId) async {

    if (key.currentState!.validate()) {
      setLoading(true);
      final geocoding.Location? location = await convertAddressToCoordinates();
      if (location != null) {
        setLat(location.latitude);
        setLng(location.longitude);
        try {

          await FirebaseFirestore.instance.collection('parkings').add({
            'user_id': userId,
            'location': _location,
            'lat': _lat,
            'lng': _lng,
            'phone_number': phoneNumber,
            'urls': urls,
            'upload_time': Timestamp.now(),
          });
          setMessage('Data successfully saved');
          setLoading(false);
        } on FirebaseException catch (e) {
          setMessage(e.code);
          setLoading(false);
        }
      } else {
        setMessage('Location can\'t be searched, please enter correct location');
        setLoading(false);
      }


    }

  }


  List<Map<String, dynamic>> _bookedCars = [];

  List<Map<String, dynamic>> get bookedCars => _bookedCars;

  void setBookedCars(List<Map<String, dynamic>> cars) {
    _bookedCars = cars;
    notifyListeners();
  }

  Future<void> fetchBookedParking(String userId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('parkings')
          .where('user_id', isEqualTo: userId)
          .get();


      List<Map<String, dynamic>> cars = [];

      for (var doc in snapshot.docs) {
        QuerySnapshot carSnapshot = await doc.reference.collection('cars').get();
        for (var carDoc in carSnapshot.docs) {
          cars.add(carDoc.data() as Map<String, dynamic>);
        }
      }

      print(cars[0]['vehicle_name']);
      setBookedCars(cars);
      notifyListeners();
    } catch (e) {
      print(e);
    }

  }

}
