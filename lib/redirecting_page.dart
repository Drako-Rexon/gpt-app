import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/view/extras/help_page.dart';
import 'package:gemini_app/view/homepage/homepage.dart';
import 'package:gemini_app/view/extras/terms_and_conditions.dart';
import 'package:gemini_app/view/todo/todo_app_page.dart';

class RedirectingPage extends StatefulWidget {
  const RedirectingPage({super.key});

  @override
  State<RedirectingPage> createState() => _RedirectingPageState();
}

class _RedirectingPageState extends State<RedirectingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _names = [
    'Home',
    'To-Do',
  ];

  final List _body = [
    const HomePage(),
    TodoPage(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        shadowColor: Colors.white,
        child: Column(
          children: [
            ListView.builder(
              itemCount: _names.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _index = index;
                      if (_scaffoldKey.currentState!.isDrawerOpen) {
                        _scaffoldKey.currentState!.openEndDrawer();
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
              },
            ),
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RedirectingPage()),
                        (route) => false));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
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
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
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
