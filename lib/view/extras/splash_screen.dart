import 'package:flutter/material.dart';
import 'package:gemini_app/controller/internet_provider.dart';
import 'package:gemini_app/redirecting_page.dart';
import 'package:gemini_app/view/extras/no_connection.dart';
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
    await Provider.of<InternetProvider>(context, listen: false)
        .checkInternet()
        .then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    value ? RedirectingPage() : const NoConnectionPage()),
            (route) => false);
      });
    });
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
