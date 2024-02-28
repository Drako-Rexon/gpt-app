import 'package:flutter/material.dart';
import 'package:gemini_app/view/homepage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/animation/loading-1.json', animate: true),
      ),
    );
  }
}
