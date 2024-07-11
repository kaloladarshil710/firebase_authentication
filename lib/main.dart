import 'package:firebase7/home_screen.dart';
import 'package:firebase7/phone_auth/sign_in_with_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  //! facht all users in firebase
  //! all document in users
  //! QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").get();

  //! for one by one document fatch in doc variable
  //  for(var doc in snapshot.docs){
  //   print(doc.data().toString());
  // }

  //! all ducument fatch  in snapshot.docs.toString
  // print(snapshot.docs.toString());



  //! perticuler documnet by docummnet id
  // DocumentSnapshot snapshot1 = await FirebaseFirestore.instance.collection("users").doc("GD2hYxDGZpQAkCNORyns").get(); // facht all users in firebase

  // print(snapshot1.data().toString());




//! for add new data in firestore
  // Map<String,dynamic> newUserData ={
  // "name" : "chintan",
  // "email" : "chintan@gmail.com"
  // };


//! using add() function new data add
// await FirebaseFirestore.instance.collection("users").add(newUserData);
// print("New User Save!");

//! for user define document name enter
// await FirebaseFirestore.instance.collection("users").doc("id-enter").set(newUserData);
// print("User Define Document Id is entered!");



//! for update data in documnet
// await FirebaseFirestore.instance.collection("users").doc("id-enter").update({"email":"chintan123@gmail.com"});
// print("Update Sucssesful!");

//! for delete document
// await FirebaseFirestore.instance.collection("users").doc("id-enter").delete();
// print("User Deleted!");






  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Firebase initialization is complete

            return FirebaseAuth.instance.currentUser != null
                ? const HomeScreen()
                : const SignInWithPhone();
          }
// Show a loading indicator while waiting for Firebase to initialize
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


