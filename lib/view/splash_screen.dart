import 'package:flutter/material.dart';
import 'package:gemini_app/controller/internet_provider.dart';
import 'package:gemini_app/view/homepage.dart';
import 'package:gemini_app/view/no_connection.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigationToPage();
  }

  navigationToPage() async {
    // bool internetResult =
    await Provider.of<InternetProvider>(context, listen: false)
        .checkInternet()
        .then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    value ? const HomePage() : const NoConnectionPage()),
            (route) => false);
      });
    });

    // Future.delayed(
    //     const Duration(seconds: 2),
    //     () => );
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
