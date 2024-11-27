import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/utils/custom_padding.dart';
import 'package:libre_doc_converter/libre_doc_converter.dart';

class DocumentConverter extends StatelessWidget {
  const DocumentConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Converter')),
      body: Center(
        child: Column(
          children: [
            const Text('Select a document type'),
            10.ah,
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                final converter = LibreDocConverter(
                  inputFile: File(result!.xFiles.first.path),
                );

                final newFile = await converter.toPdf();

                log('the path of new file: ${newFile.path}');
              },
              child: const Text('Word to PDF'),
            ),
            10.ah,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Excel to PDF'),
            ),
            10.ah,
            ElevatedButton(onPressed: () {}, child: const Text(''))
          ],
        ),
      ),
    );
  }
}
