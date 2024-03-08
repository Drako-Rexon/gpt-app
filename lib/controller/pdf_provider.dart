import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PDFProvider extends ChangeNotifier {
  static final PDFProvider _instance = PDFProvider._internal();
  factory PDFProvider() => _instance;
  PDFProvider._internal();

  List<XFile> imageList = [];

  void clearSelectedImages() {
    imageList.clear();
  }
}
