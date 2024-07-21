import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_app/view/extras/splash_screen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SplashScreen()),
                (route) => false);
          },
          child: Container(
            width: 345,
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 47.50),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x2A000000),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x15000000),
                  blurRadius: 3,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0.50,
                              top: 0.50,
                              child: SizedBox(
                                width: 23,
                                height: 23,
                                child: SvgPicture.asset(
                                    'assets/svg/google-logo.svg'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Sign In with Google',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5400000214576721),
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn() async {
    try {
      // GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // AuthCredential credential = GoogleAuthProvider.credential(
      //     accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // UserCredential user =
      //     await FirebaseAuth.instance.signInWithCredential(credential);

      // log("response: " + user.user!.displayName!);
    } catch (err) {
      log('Error Occured');
    }
  }
}

/*

Platform  Firebase App Id
web       1:468857642875:web:258979fa269dfa5f2527de
android   1:468857642875:android:2b9cc08608ab7e602527de
ios       1:468857642875:ios:411891d91960f7a52527de
macos     1:468857642875:ios:6259d2af0f93a0702527de

*/
