import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_app/providers/permission_whatsapp_provider.dart';
import 'package:gemini_app/view/whatsapp_saver/image_page/image_view.dart';
import 'package:provider/provider.dart';

class ImageHomePage extends StatefulWidget {
  const ImageHomePage({super.key});

  @override
  State<ImageHomePage> createState() => _ImageHomePageState();
}

class _ImageHomePageState extends State<ImageHomePage> {
  bool isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusProvider>(
        builder: (ctx, val, _) {
          if (!isFetched) {
            val.getStatus(".jpg");
            Future.delayed(
                const Duration(milliseconds: 10), () => isFetched = true);
          }
          return Visibility(
            visible: val.isWhatsAppAvailable,
            replacement: const Center(child: Text("No WhatsApp Available...")),
            child: Visibility(
              visible: val.getImages.isNotEmpty,
              replacement: const Center(child: Text("No Images Available")),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  children: List.generate(
                    val.getImages.length,
                    (index) {
                      final data = val.getImages[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImageView(imagePath: data.path),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(data.path)),
                            ),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  offset: Offset(2, -2))
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
