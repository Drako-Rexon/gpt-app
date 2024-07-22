import 'package:flutter/material.dart';

popupWindow(BuildContext context, String title, String? content) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: context == null ? const Text('') : Text(content!),
        );
      });
}
