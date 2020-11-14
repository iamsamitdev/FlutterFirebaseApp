import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static Stream<User> firebaseListner = _firebaseAuth.authStateChanges();

  // สร้างฟังก์ชันสำหรับการ login
  static void firebaseSignIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user.email);
      print(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print('Invalide email');
        Fluttertoast.showToast(
            msg: 'Invalide email',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'user-not-found') {
        print('No user found for that email.');
         Fluttertoast.showToast(
            msg: 'No user found for that email.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
            msg: 'Wrong password provided for that user.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        print(e.code);
      }
    } catch (e) {
      print(e);
    }
  }

  // สร้างฟังก์ชันสำหรับการ regsiter
  static void firebaseRegister(String email, String password) async {
    try {
      final _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(_authResult);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(
            msg: 'The password provided is too weak',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  // สร้างฟังก์ชันสำหรับการดึงข้อมูล User ออกมาใช้
  static firebaseUserDetail() {
    final User user = _firebaseAuth.currentUser;
    return user.email;
  }

  // สร้างฟังก์ชันสำหรับการ logout
  static void firebaseLogout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
