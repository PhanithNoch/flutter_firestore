import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(String full_name, String phone) {
    return users
        .doc()
        .set({'full_name': full_name, 'phone': phone})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void _clearForm() {
    nameController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: phoneController,
            ),
            TextButton(
                onPressed: () {
                  addUser(nameController.text, phoneController.text);
                  _clearForm();
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
