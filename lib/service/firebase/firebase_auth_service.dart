import 'package:firebaseApp/screen/login_screen.dart';
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
  static firebaseRegister(String email, String password) async {
    // BuildContext context;
    try {
      final _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // print(_authResult);
      // Navigator.pushReplacementNamed(context, '/login');
      // Navigator.of(context).pushReplacementNamed('/login');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginScreen()),
      // );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(
            msg: 'รหัสผ่านสั้นเกินไป ต้องยาวไม่น้อยกว่า 6 ตัวอักษร',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: 'มีอีเมล์นี้แล้วในระบบ กรุณาใช้อีเมล์อื่น',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return false;
    } catch (e) {
      print(e);
      return false;
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
