import 'package:firebase7/phone_auth/verify_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({ Key? key }) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  final TextEditingController phoneController = TextEditingController();

  void sendOTP() async {
    
    try {
      String phone = "+91" + phoneController.text.trim();
      // phoneController.clear();   
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOtpScreen(verificationId: verificationId),
            ),
          );
        },
        verificationCompleted: (PhoneAuthCredential credential) {
          // Optional: Handle auto-retrieval or instant verification if needed
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle error appropriately
          print('Verification failed: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed. Please try again.')),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle auto-retrieval timeout if needed
        },
        timeout: Duration(seconds: 30),
      );
    } catch (e) {
      // Handle any unexpected errors
      print('Error sending OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In with Phone"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      prefixText: "+91",
                    ),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: sendOTP,
                    color: Colors.blue,
                    child: Text("Sign In", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
