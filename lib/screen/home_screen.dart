import 'package:firebaseApp/service/firebase/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var getUser = FirebaseAuthService.firebaseUserDetail();

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app), 
            onPressed: () {
              FirebaseAuthService.firebaseLogout();
              Navigator.pushReplacementNamed(context, '/login');
            }
          )
        ],
      ),
      body: Center(
        child: Text(getUser),
      ),
    );
  }
}