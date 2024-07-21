import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/redirecting_page.dart';

class OTPPage extends StatelessWidget {
  OTPPage({super.key, required this.verificationId});
  final String verificationId;
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _otpController,
            ),
          ),
          TextButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: _otpController.text);
                  await FirebaseAuth.instance
                      .signInWithCredential(phoneAuthCredential)
                      .then((val) {
                    log(val.user!.phoneNumber.toString());
                    log(val.user!.uid.toString());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RedirectingPage()),
                        (route) => false);
                  });
                } catch (e) {
                  log(e.toString());
                }
              },
              child: const Text('Verify OTP'))
        ],
      ),
    );
  }
}
