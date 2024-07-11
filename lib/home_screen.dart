

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase7/edit_user_page.dart';
import 'package:firebase7/phone_auth/sign_in_with_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  
  get currentAge => null;


  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignInWithPhone()),
    );
  }

  void saveUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String ageString = ageController.text.trim();
    int age = int.parse(ageString);
    


    if (name != "" && email != "" && age != "") {
      Map<String, dynamic> userData = {"name": name, "email": email ,"age" :age};
      try {
        await FirebaseFirestore.instance.collection("users").add(userData);
        nameController.clear();
        emailController.clear();
        ageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Created!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create user: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields!')),
      );
    }
  }

  void editUser(String docId, String currentName, String currentEmail , int age) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditUserPage(
          docId: docId,
          currentName: currentName,
          currentEmail: currentEmail,
          currentAge: currentAge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: logOut,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              MaterialButton(
                onPressed: () async{
                  XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if(selectedImage != null){
                    print("Image Selected!");
                  }else {
                    print("No Image Selected!");
                  }

                  },
                padding: EdgeInsets.zero,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  hintText: "Age",
                ),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                onPressed: saveUser,
                color: const Color.fromARGB(255, 45, 151, 238),
                textColor: Colors.white,
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
             
                  //! Equal To: Filters documents where a field is equal to a certain value.
              // FirebaseFirestore.instance.collection("users").where("age", isEqualTo: 25).snapshots();
                //! Not Equal To: Filters documents where a field is not equal to a certain value.
              // FirebaseFirestore.instance.collection("users").where("age", isNotEqualTo: 25).snapshots();
                //! Less Than: Filters documents where a field is less than a certain value.
              // FirebaseFirestore.instance.collection("users").where("age", isLessThan: 30).snapshots();
                //! Less Than or Equal To: Filters documents where a field is less than or equal to a certain value.
              // FirebaseFirestore.instance.collection("users").where("age", isLessThanOrEqualTo: 30).snapshots();
                //! Greater Than: Filters documents where a field is greater than a certain value
              // FirebaseFirestore.instance.collection("users").where("age", isGreaterThan: 20).snapshots();
                //! Greater Than or Equal To: Filters documents where a field is greater than or equal to a certain value.
              // FirebaseFirestore.instance.collection("users").where("age", isGreaterThanOrEqualTo: 20).snapshots();
                //! Array Contains: Filters documents where an array field contains a specific element.
              // FirebaseFirestore.instance.collection("users").where("interests", arrayContains: "sports").snapshots();
                //! Array Contains Any: Filters documents where an array field contains any of the specified elements.
              // FirebaseFirestore.instance.collection("users").where("interests", arrayContainsAny: ["sports", "music"]).snapshots(); 
                //! Array Contains All: Filters documents where an array field contains all of the specified elements.
              // FirebaseFirestore.instance.collection("users").where("interests", arrayContainsAll: ["sports", "music"]).snapshots();
                //! Compound Queries: Combines multiple conditions using logical operators (&&, ||)
              // FirebaseFirestore.instance.collection("users").where("age", isGreaterThan: 20).where("age", isLessThan: 30).snapshots();
                //! Order and Limit: Orders documents and limits the number of results returned.
              // FirebaseFirestore.instance.collection("users").where("age", isGreaterThan: 20).orderBy("age").limit(10).snapshots();
              //! give perticular data 
              //  FirebaseFirestore.instance.collection("users").where("age",whereIn:[18,20,30]).snapshots();
          
              StreamBuilder<QuerySnapshot>(
                //! normal without filter
                stream: FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            Map<String, dynamic> userMap = doc.data() as Map<String, dynamic>;
          
                            return ListTile(
                              title: Text("${userMap["name"]}(${userMap["age"]})"),
                              subtitle: Text(userMap["email"]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      editUser(doc.id, userMap["name"], userMap["email"],userMap["age"]);
          
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection("users").doc(doc.id).delete();
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text("No Data");
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}