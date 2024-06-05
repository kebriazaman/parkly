import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/main_menu/view/parking_details_screen.dart';

import '../../main_menu/model/parking_model.dart';

class MainMenuProvider extends ChangeNotifier {
  GoogleMapController? _googleMapController;
  CarouselController carouselController = CarouselController();

  DateTime? _fromDate;
  DateTime? _toDate;

  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;

  void setDatePickerFromDate(DateTime date) {
    _fromDate = date;
    notifyListeners();
  }

  void setDatePickerToDate(DateTime date) {
    _toDate = date;
    notifyListeners();
  }

  List<Parking> _parkings = [];
  final Set<Marker> _markers = {};
  LatLng? _currentPosition;
  int _carouselCurrentIndex = 0;
  bool _gettingImages = false;


  final ImagePicker _picker = ImagePicker();

  Parking? _parking;
  String _vehicleName = '';
  String _totalHours = '';
  String _message = '';
  bool _isLoading = false;
  bool _isDone = false;

  List<String> urls = <String>[];

  List<XFile> selectedImages = <XFile>[];

  Parking get parking => _parking!;
  int get carouselCurrentIndex => _carouselCurrentIndex;
  bool get gettingImages => _gettingImages;
  bool get isLoading => _isLoading;
  bool get isDone => _isDone;
  String get vehicleName => _vehicleName;
  String get totalHours => _totalHours;
  String get message => _message;


  void setDoneValue(bool v) {
    _isDone = v;
    notifyListeners();
  }

  void setIsLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
  void setMessageValue(String v) {
    _message = v;
    notifyListeners();
  }

  void setTotalHours(String v) {
    _totalHours = v;
    notifyListeners();
  }

  void setVehicleName(String v) {
    _vehicleName = v;
    notifyListeners();
  }

  void setGettingImagesValue(bool v) {
    _gettingImages = v;
    notifyListeners();
  }

  void setCarouselCurrentIndex(int i) {
    _carouselCurrentIndex = i;
    notifyListeners();
  }

  void setParkingValue(Parking p){
    _parking = p;
    notifyListeners();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GoogleMapController? get googleMapController => _googleMapController;
  List<Parking> get parkings => _parkings;
  Set<Marker> get markers => _markers;
  LatLng? get currentPosition => _currentPosition;

  void onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
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


  Future<void> fetchParkings() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('parkings').get();
      final List<Parking> loadedParkings = [];

      for (var doc in snapshot.docs) {
        loadedParkings.add(Parking.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
      }
      _parkings = loadedParkings;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void setMarkers(context) {
    _markers.clear();

    for (var parking in _parkings) {
      _markers.add(
        Marker(
          markerId: MarkerId(parking.id),
          position: LatLng(parking.lat, parking.lng),
          infoWindow: InfoWindow(
            title: parking.location,
          ),
          onTap: () {
            setParkingValue(parking);
            Navigator.pushNamed(context, RouteNames.parkingDetailsScreen, arguments: parking);
          },
        ),
      );
      notifyListeners();
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentPosition = LatLng(position.latitude, position.longitude);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> bookParking(GlobalKey<FormState> key) async {
    if (key.currentState!.validate()) {
      setIsLoading(true);
      _firestore.collection('parkings').doc(parking.id).collection('cars').add({
        'vehicle_name': _vehicleName,
        'from_date': '${_fromDate?.day}/${_fromDate?.month}/${_fromDate?.year}',
        'to_date': '${_toDate?.day}/${_toDate?.month}/${_toDate?.year}',
        'total_hours': _totalHours,
        'urls': urls,
      }).then((value) {
        setIsLoading(false);
        _message = 'Space booked';
        notifyListeners();
        setDoneValue(true);

      }).onError((error, stackTrace) {
        setIsLoading(false);
        _message = 'Error booking parking';
        notifyListeners();
        setMessageValue('Error booking parking');
        setDoneValue(false);
      });
    }
  }

}
