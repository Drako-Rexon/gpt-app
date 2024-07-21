import 'package:flutter/material.dart';
import 'package:gemini_app/view/help_page.dart';
import 'package:gemini_app/view/homepage/homepage.dart';
import 'package:gemini_app/view/extras/terms_and_conditions.dart';

class RedirectingPage extends StatefulWidget {
  const RedirectingPage({super.key});

  @override
  State<RedirectingPage> createState() => _RedirectingPageState();
}

class _RedirectingPageState extends State<RedirectingPage> {
  final List<String> _names = ['Home', 'To-Do'];

  final List _body = [
    const HomePage(),
    const HomePage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shadowColor: Colors.white,
        child: ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _index = index;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _index == index ? Colors.blueAccent : Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    _names[index],
                    style: TextStyle(
                      color: _index != index ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              );
            }),
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
              return ['Help', 'Terms & Conditions'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _body[_index],
    );
  }

  void handleClick(String value, BuildContext context) {
    switch (value) {
      case 'Terms & Conditions':
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const TermsAndConditions()));
        break;
      case 'Help':
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HelpPage()));
        break;
    }
  }
}
