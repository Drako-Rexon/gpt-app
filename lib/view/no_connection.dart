import 'package:flutter/material.dart';
import 'package:gemini_app/view/splash_screen.dart';
import 'package:lottie/lottie.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animation/no-internet.json', animate: true),
            const Text('No Internet Connection'),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                      (route) => false);
                },
                child: const Text('Retry'))
          ],
        ),
      ),
    );
  }
}
