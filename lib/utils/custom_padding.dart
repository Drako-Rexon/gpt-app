import 'package:flutter/material.dart';

extension CustomPadding on int {
  SizedBox get ah => SizedBox(height: toDouble());
  SizedBox get aw => SizedBox(width: toDouble());
}
