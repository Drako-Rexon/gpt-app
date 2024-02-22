import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late String _name;
  late String _apikey;

  String get name => _name;
  String get apikey => _apikey;

  void setName(String name) {
    _name = name;
  }
}
