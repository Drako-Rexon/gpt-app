import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_app/view/chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.blue,
        elevation: 4,
      ),
      body: Column(
        children: [
          Row(
            children: [
              InkWell(
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
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (_) => const ChatPage()));
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(20),
              //     height: 200,
              //     width: (MediaQuery.of(context).size.width / 2) - 30,
              //     margin:
              //         const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              //     decoration: BoxDecoration(
              //         color: Colors.blue[100],
              //         borderRadius:
              //             const BorderRadius.all(Radius.circular(18))),
              //     child: SvgPicture.asset(
              //       'assets/svg/gemini-logo.svg',
              //       height: 120,
              //       width: 120,
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
