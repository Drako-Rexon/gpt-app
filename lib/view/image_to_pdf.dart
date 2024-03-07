import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_app/controller/pdf_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageToPDF extends StatefulWidget {
  const ImageToPDF({super.key});

  @override
  State<ImageToPDF> createState() => _ImageToPDFState();
}

class _ImageToPDFState extends State<ImageToPDF> {
  // final List<XFile> _image = [];
  PDFProvider _image = PDFProvider();

  void getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      _image.clearSelectedImages();
      _image.imageList.addAll(images);
      setState(() {});
    } else {
      log('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue[100],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: getImageFromGallery,
                  child: const Text('Pick Images')),
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
            shrinkWrap: true,
            itemCount: _image.imageList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 200,
                width: 80,
                margin: const EdgeInsets.all(10),
                child: Image(
                  image: FileImage(File(_image.imageList[index].path)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
