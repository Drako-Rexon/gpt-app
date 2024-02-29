import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetProvider extends ChangeNotifier {
  Future<bool> checkInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
