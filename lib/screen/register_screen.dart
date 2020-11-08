import 'package:firebaseApp/res/style.dart';
import 'package:firebaseApp/service/firebase/firebase_auth_service.dart';
import 'package:firebaseApp/widget/button_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:40.0, left:16.0, right: 16.0),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 80.0,
                  height: 80.0,
                ),
                SizedBox(height: 50,),
                TextFormField(
                  decoration: styleInputDecoration.copyWith(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  style: styleTextFieldText,
                  onChanged: (value) => _email = value,
                  validator: (value) => value.trim().isEmpty ? 'Enter email address': null,
                ),
                SizedBox(height: 16,),
                TextFormField(
                  decoration: styleInputDecoration.copyWith(labelText: 'Password'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLines: 1,
                  style: styleTextFieldText,
                  onChanged: (value) => _password = value,
                  validator: (value) => value.trim().isEmpty ? 'Enter password': null,
                ),
                SizedBox(height: 16,),
                TextFormField(
                  decoration: styleInputDecoration.copyWith(labelText: 'Confirm Password'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLines: 1,
                  style: styleTextFieldText,
                  onChanged: (value) => _confirmPassword = value,
                  validator: (value) => value.trim().isEmpty || value.trim() != _password.trim() ? 'Password mismatch': null,
                ),
                SizedBox(height: 20,),
                ButtonWidget(
                  buttonText: 'REGISTER', 
                  onClick: (){
                    print(_email);
                    if(_formKey.currentState.validate()){
                      FirebaseAuthService.firebaseRegister(_email, _password);
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  }
                ),
                SizedBox(height: 20,),
                InkWell(
                  child: RichText(
                    text: TextSpan(
                      text: "If your have an account?",
                      style: styleSmallText,
                      children: [
                        TextSpan(
                          text: ' Back to login page.',
                          style: styleSmallText.copyWith(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}