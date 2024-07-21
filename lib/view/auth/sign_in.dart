import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/view/auth/otp_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: _phoneController,
              ),
            ),
            TextButton(
              onPressed: () async {
                FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: _phoneController.text,
                  verificationCompleted:
                      (PhoneAuthCredential phoneAuthCredential) {},
                  verificationFailed: (FirebaseAuthException ex) {},
                  codeSent: (String verificationId, int? resendToken) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                OTPPage(verificationId: verificationId)));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
