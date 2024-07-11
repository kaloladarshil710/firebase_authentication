

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  final String docId;
  final String currentName;
  final String currentEmail;
  final int currentAge;

  const EditUserPage({
    Key? key,
    required this.docId,
    required this.currentName,
    required this.currentEmail,
    required this.currentAge,
  }) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
    ageController = TextEditingController(text: widget.currentAge.toString());
  }

  void updateUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String ageString = ageController.text.trim();

    if (name != "" && email != "" && ageString != "") {
      int age = int.parse(ageString);
      Map<String, dynamic> updatedUserData = {"name": name, "email": email, "age": age};
      try {
        await FirebaseFirestore.instance.collection("users").doc(widget.docId).update(updatedUserData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Updated!')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: updateUser,
              color: const Color.fromARGB(255, 45, 151, 238),
              textColor: Colors.white,
              child: const Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
