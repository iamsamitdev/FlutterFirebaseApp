import 'package:firebaseApp/screen/home_screen.dart';
import 'package:firebaseApp/screen/login_screen.dart';
import 'package:firebaseApp/screen/phone_login_screen.dart';
import 'package:firebaseApp/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

const routeLogin = '/login';
const routeRegister = '/register';
const routeHome = '/home';
const routePhoneLogin = '/phoneLogin';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case routeLogin:
        return PageTransition(
          child: LoginScreen(), 
          type: PageTransitionType.rightToLeft
        );
        break;
      case routeRegister:
        return PageTransition(
          child: RegisterScreen(), 
          type: PageTransitionType.rightToLeft
        );
        break;
      case routeHome:
        return PageTransition(
          child: HomeScreen(), 
          type: PageTransitionType.rightToLeft
        );
        break;
      case routePhoneLogin:
        return PageTransition(
          child: PhoneLoginScreen(), 
          type: PageTransitionType.rightToLeft
        );
        break;
      default:
        return PageTransition(
          child: LoginScreen(), 
          type: PageTransitionType.rightToLeft
        );
        break;
    }
  }
}