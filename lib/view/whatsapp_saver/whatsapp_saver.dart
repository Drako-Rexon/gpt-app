import 'package:flutter/material.dart';
import 'package:gemini_app/view/whatsapp_saver/image_page/whatsapp_image_page.dart';
import 'package:gemini_app/view/whatsapp_saver/video_page/whatsapp_video_page.dart';

class WhatsappSaver extends StatefulWidget {
  const WhatsappSaver({super.key});

  @override
  State<WhatsappSaver> createState() => _WhatsappSaverState();
}

class _WhatsappSaverState extends State<WhatsappSaver> {
  List pages = [
    const ImageHomePage(),
    const VideoHomePage(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (val) {
          setState(() {
            _index = val;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.image), label: "Images"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_call), label: "Videos"),
        ],
      ),
    );
  }
}
