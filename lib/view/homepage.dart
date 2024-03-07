import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_app/view/chat_page.dart';
import 'package:gemini_app/view/help_page.dart';
import 'package:gemini_app/view/image_to_pdf.dart';
import 'package:gemini_app/view/terms_and_conditions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void handleClick(String value, BuildContext context) {
    switch (value) {
      case 'Terms & Conditions':
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const TermsAndconditions()));
        break;
      case 'Help':
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HelpPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shadowColor: Colors.white,
        child: Container(),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.blue,
        elevation: 4,
        actions: [
          PopupMenuButton<String>(
            onSelected: (choice) {
              handleClick(choice, context);
            },
            itemBuilder: (BuildContext context) {
              return {'Help', 'Terms & Conditions'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                overlayColor: MaterialStateProperty.all(Colors.transparent),
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
