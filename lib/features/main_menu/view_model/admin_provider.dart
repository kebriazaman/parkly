import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
class AdminProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool v) => _isLoading = v;


  void getImagesFromGallery() async {
  }

}