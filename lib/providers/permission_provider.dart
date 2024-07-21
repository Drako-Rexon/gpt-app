import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider extends ChangeNotifier {
  Future<PermissionStatus> storagePermission() async {
    PermissionStatus storageStatus = await Permission.storage.status;

    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
    storageStatus = await Permission.storage.status;

    return storageStatus;
  }

  Future<PermissionStatus> cameraPermission() async {
    PermissionStatus cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }

    cameraStatus = await Permission.camera.status;
    return cameraStatus;
  }
}
