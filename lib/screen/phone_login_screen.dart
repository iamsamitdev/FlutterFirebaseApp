import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneLoginScreen extends StatelessWidget {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  TextEditingController phoneController = TextEditingController();
  TextEditingController smsController = TextEditingController();

  Widget buildButtonVerify() {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Sign in with Phone",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green[200]),
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(12)),
        onTap: () {});
  }

  Widget buildButtonSendSms() {
    return InkWell(
        child: Container(
            height: 50,
            width: 100,
            child: Text("Send",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.orange[300]),
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(left: 8)),
        onTap: () {});
  }

  Container buildTextFieldPhoneNumber() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 8),
        constraints: BoxConstraints.expand(height: 50),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: phoneController,
            decoration: InputDecoration.collapsed(hintText: "xx-xxx-xxxx"),
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldSmsVerification() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: smsController,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration.collapsed(hintText: "SMS verify"),
            style: TextStyle(fontSize: 18)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title: Text('เข้าสู่ระบบด้วยเบอร์โทรศัพท์',style: GoogleFonts.kanit(),),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
      //     child: Container(
      //       child: Column(
      //         children: [
      //           Row(
      //             children: [
      //               Container(
      //                   padding: EdgeInsets.all(12),
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(16),
      //                       color: Colors.green[100]),
      //                   child: Text("+66",
      //                       style: TextStyle(
      //                           fontSize: 18, color: Colors.black54))),
      //               Expanded(child: buildTextFieldPhoneNumber()),
      //               buildButtonSendSms(),
      //               buildTextFieldSmsVerification(),
      //               buildButtonVerify()
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
