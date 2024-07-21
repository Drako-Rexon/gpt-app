import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_app/providers/pdf_provider.dart';
import 'package:gemini_app/providers/permission_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:external_path/external_path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;

class ImageToPDF extends StatefulWidget {
  const ImageToPDF({super.key});

  @override
  State<ImageToPDF> createState() => _ImageToPDFState();
}

class _ImageToPDFState extends State<ImageToPDF> {
  final PDFProvider _image = PDFProvider();
  TextEditingController pdfName = TextEditingController();

  void getImageFromGallery() async {
    PermissionProvider permissionProvider =
        Provider.of<PermissionProvider>(context, listen: false);
    bool storageStatus = await permissionProvider.storagePermission().isGranted;

    if (storageStatus) {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      if (images.isNotEmpty) {
        _image.clearSelectedImages();
        setState(() {
          _image.imageList.addAll(images);
        });
      } else {
        log('No image selected');
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Storage Permission Denied'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          });
    }
  }

  void pickImageCamera() async {
    PermissionProvider permissionProvider =
        Provider.of<PermissionProvider>(context, listen: false);
    bool cameraStatus = await permissionProvider.cameraPermission().isGranted;

    if (cameraStatus) {
      final ImagePicker picker = ImagePicker();
      final XFile? singleImage =
          await picker.pickImage(source: ImageSource.camera);

      if (singleImage != null) {
        setState(() {
          _image.imageList.add(singleImage);
        });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('No image is clicked'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Camera Permission Denied'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          });
    }
  }

  void converToPDF() async {
    final pathToSave = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOCUMENTS);

    final pdf = pw.Document();

    for (final imagePath in _image.imageList) {
      final imageBytes = await File(imagePath.path).readAsBytes();
      final image = img.decodeImage(imageBytes);

      if (image != null) {
        final pdfImage = pw.MemoryImage(imageBytes);

        pdf.addPage(pw.Page(build: (pw.Context context) {
          return pw.Center(child: pw.Image(pdfImage));
        }));
      }

      setState(() {
        // update loading values
      });
    }

    final outputFile = await File(
            '$pathToSave/${pdfName.text == "" ? "New Pdf-${DateTime.now()}" : pdfName.text}.pdf')
        .create(recursive: true);
    await outputFile.writeAsBytes(await pdf.save());

    MediaScanner.loadMedia(path: outputFile.path);
    log('done');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: pdfName,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: getImageFromGallery,
                        child: const Text('Pick Images')),
                    TextButton(
                        onPressed: pickImageCamera,
                        child: const Text('Click Images')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _image.clearSelectedImages();
                          });
                        },
                        child: const Text('Clear')),
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _image.imageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    double sizefactor = 400;
                    return Container(
                      height: 1.41 * sizefactor,
                      width: 1 * sizefactor,
                      margin: const EdgeInsets.all(10),
                      child: Image(
                        image: FileImage(File(_image.imageList[index].path)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: TextButton(
                onPressed: converToPDF,
                child: const Text('Convert'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
