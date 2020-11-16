import 'package:firebaseApp/widget/bottom_sheet_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {

  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static Stream<User> firebaseListner = _firebaseAuth.authStateChanges();

  // สร้างฟังก์ชันสำหรับการขอ SMS OTP
  Future createUserWithPhone(String phone, BuildContext context) async {

    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone, 
      timeout: Duration(seconds: 0),
      verificationCompleted: (AuthCredential authCredential){
          _firebaseAuth.signInWithCredential(authCredential).then((UserCredential result){
            Navigator.of(context).pop(); // to pop the dialog box
            Navigator.of(context).pushReplacementNamed('/home');
          }).catchError((e) {
            print("Error complete");
            return "error";
          });
      },
      verificationFailed: (FirebaseAuthException exception) {
          return "error";
      }, 
      codeSent: (String verificationId, [int forceResendingToken]) {
          final _codeController = TextEditingController();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("ป้อนรหัส OTP ที่ได้รับ"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("ยืนยัน"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                      var _credential = PhoneAuthProvider.credential(verificationId: verificationId,
                          smsCode: _codeController.text.trim());
                      _firebaseAuth.signInWithCredential(_credential).then((UserCredential result){
                        Navigator.of(context).pop(); // to pop the dialog box
                        Navigator.of(context).pushReplacementNamed('/home');
                      }).catchError((e) {
                        // return "error";
                        BottomSheetWidget().bottomSheet(context, "มีข้อผิดพลาด", "ป้อนรหัส OTP ไม่ถูกต้อง");
                      });
                  },
                )
              ],
            ),
          );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
      });

  }

  // สร้างฟังก์ชันสำหรับการ login ด้วย Email
  Future firebaseSignIn(BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        BottomSheetWidget().bottomSheet(context, "มีข้อผิดพลาด", "ป้อนอีเมล์ไม่ถูกต้อง");
      } else if (e.code == 'user-not-found') {
        BottomSheetWidget().bottomSheet(context, "มีข้อผิดพลาด", "ไม่พบอีเมล์นี้ในระบบ");
      } else if (e.code == 'wrong-password') {
        BottomSheetWidget().bottomSheet(context, "มีข้อผิดพลาด", "รหัสผ่านไม่ถูกต้อง");
      } else {
        print(e.code);
      }
    } catch (e) {
      print(e);
    }
  }

  // สร้างฟังก์ชันสำหรับการ regsiter
  Future firebaseRegister(BuildContext context,String email, String password) async {

    try {

      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, '/home');      
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        BottomSheetWidget().bottomSheet(context, "มีข้อผิดพลาด", "รหัสผ่านสั้นหรือง่ายเกินไป ไม่ปลอดภัย");
      } else if (e.code == 'email-already-in-use') {
        BottomSheetWidget().bottomSheet(context, "มีข้อผิดพลาด", "มีบัญชีนี้อยู่แล้วในระบบ ลองใช้อีเมล์อื่น");
      } else if(e.code == 'invalid-email'){
        BottomSheetWidget().bottomSheet(context, "มีข้อผิดพลาด", "รูปแบบอีเมล์ไม่ถูกต้อง");
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
    return user;
  }


  // สร้างฟังก์ชันสำหรับการ logout
  Future firebaseLogout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
