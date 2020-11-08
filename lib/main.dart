import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseApp/res/color.dart';
import 'package:firebaseApp/route/routes.dart';
import 'package:firebaseApp/screen/home_screen.dart';
import 'package:firebaseApp/screen/login_screen.dart';
import 'package:firebaseApp/service/firebase/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // กำหนดให้รองรับการอ่าน api ผ่าน https
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // กำหนดให้แสดงผลเฉพาะแนวตั้ง
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: colorPrimaryDark,
      systemNavigationBarColor: colorPrimaryDark
    )
  );
  runApp(
    StreamProvider(
      create: (BuildContext context) => FirebaseAuthService.firebaseListner,
      child: MaterialApp(
        theme: ThemeData(
          primaryColorDark: colorPrimaryDark,
          accentColor: colorPrimaryDark,
          primaryColor: colorPrimary
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
        home: MyApp(),
      ),
    )

  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<User>(context) == null ? LoginScreen() : HomeScreen();
  }
}