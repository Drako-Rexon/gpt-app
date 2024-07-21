import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_app/view/gemini/chat_page.dart';
import 'package:gemini_app/view/pdf/image_to_pdf.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ChatPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  width: (MediaQuery.of(context).size.width / 2) - 30,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(18))),
                  child: SvgPicture.asset(
                    'assets/svg/gemini-logo.svg',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ImageToPDF()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  width: (MediaQuery.of(context).size.width / 2) - 30,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(18))),
                  child: SvgPicture.asset(
                    'assets/svg/pdf.svg',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
