import 'package:flutter/material.dart';

class ImageToPDF extends StatelessWidget {
  const ImageToPDF({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
        backgroundColor: Colors.blue[100],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue[100],
          )
        ],
      ),
    );
  }
}
