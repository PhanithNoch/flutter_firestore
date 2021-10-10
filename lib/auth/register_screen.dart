import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text("Register"),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              helperText: "Email",
            ),
          ),
          TextField(
            controller: passController,
            decoration: InputDecoration(
              helperText: "Password",
            ),
          ),
          TextButton(onPressed: () {}, child: Text("Sign up"))
        ],
      ),
    );
  }
}
