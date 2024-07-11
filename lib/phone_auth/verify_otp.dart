
import 'package:firebase7/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String verificationId;

  VerifyOtpScreen({required this.verificationId});

  final TextEditingController otpController = TextEditingController();

  void verifyOtp(BuildContext context) async {
    String otp = otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Handle successful sign-in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification successful')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Handle error
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () => verifyOtp(context),
              color: Colors.blue,
              child: const Text('Verify', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 30),

            

          ],
        ),
      ),
    );
  }
}
