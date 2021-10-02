import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String docId;
  UpdateScreen({required this.docId});

  @override
  _CreateScreenState createState() => _CreateScreenState(docId: this.docId);
}

class _CreateScreenState extends State<UpdateScreen> {
  _CreateScreenState({required this.docId});
  final String docId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String fullName = '';
  String phone = '';

  Future<void> updateUser(String full_name, String phone, String docId) {
    return users
        .doc(docId)
        .update({'full_name': full_name, 'phone': phone})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void _clearForm() {
    nameController.clear();
    phoneController.clear();
  }

  void fetchUserById() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        phoneController.text = documentSnapshot.get('phone');
        nameController.text = documentSnapshot.get('full_name');

        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  void initState() {
    fetchUserById();
    super.initState();
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
                  updateUser(nameController.text, phoneController.text, docId);
                  _clearForm();
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
