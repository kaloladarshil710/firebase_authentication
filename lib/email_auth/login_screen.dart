import 'package:firebase7/email_auth/signup_screen.dart';
import 'package:firebase7/home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ super.key });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();


void login() async{
	String email = emailController.text.trim();
	String password = passwordController.text.trim();

	if(email == "" ||  password =="" ){
		print("Please fil all the details");
	}else{
		try{
			UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
			
			if(userCredential.user != null){
			Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
			}
		} on FirebaseAuthException catch(ex){
			print(ex.code.toString());
		}
	}
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email Address"
                    ),
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),

                  SizedBox(height: 20,),

                  MaterialButton(
                    onPressed: () {
                      login();
                    },
                    color: Colors.blue,
                    child: Text("Log In"),
                  ),

                  SizedBox(height: 10,),

                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SignUpScreen()
                      ));
                    },
                    child: Text("Create an Account"),
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