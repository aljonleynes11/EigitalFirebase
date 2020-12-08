import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:EigitalFacebook/Commons/CustomTextField.dart';
import 'package:EigitalFacebook/Extensions/color.dart';
import 'package:EigitalFacebook/Helpers/CustomSpacer.dart';
import 'package:EigitalFacebook/Router.dart';
import 'package:EigitalFacebook/Services/AuthManager.dart';

import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:EigitalFacebook/Constants/LoginMethod.dart';
import 'package:EigitalFacebook/Constants/Constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController logInEmail = TextEditingController();
  TextEditingController logInPassword = TextEditingController();
  //register
  TextEditingController registerEmail = TextEditingController();
  TextEditingController registerPassword = TextEditingController();

  bool isToRegister = false;
  Color gradientColor1 = Colors.tealAccent;
  Color gradientColor2 = HexColor("#FFFFFF");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: (Container(
            color: Colors.white,
            child: Column(
              children: [
                header(),
                CustomSpacer(height: 0.05),
                (isToRegister == false) ? loginForm() : registerForm(),
                loginButtons()
              ],
            ))));
  }

//widgets
  Widget header() {
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(children: [
            Image.asset("assets/sampleLogo.png"),
            Text('Eigital Coding Exam', style: TextStyle(color: Colors.black)),
          ]),
        ));
  }

  Widget loginForm() {
    return Container(
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              CustomTextField(
                placeholder: 'Login Email',
                controller: logInEmail,
                hideText: false,
              ),
              CustomSpacer(height: 0.02),
              CustomTextField(
                placeholder: 'Login Password',
                controller: logInPassword,
                hideText: true,
              ),
              CustomSpacer(height: 0.02),
              RaisedButton(
                child: Text('Login'),
                color: Colors.blue[600],
                padding: const EdgeInsets.symmetric(horizontal: 140),
                onPressed: () => _validateLogin(),
              ),
              FlatButton(
                child: Text('Create your account'),
                textColor: Colors.blueGrey,
                onPressed: () => setState(() {
                  isToRegister = true;
                  gradientColor1 = Colors.deepOrange;
                }),
              ),
            ],
          ),
        ));
  }

  Widget registerForm() {
    return Container(
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              CustomTextField(
                placeholder: 'Register Email',
                controller: registerEmail,
                hideText: false,
                bgColor: Colors.deepOrange,
              ),
              CustomSpacer(height: 0.02),
              CustomTextField(
                placeholder: 'Register Password',
                controller: registerPassword,
                hideText: true,
                bgColor: Colors.deepOrange,
              ),
              CustomSpacer(height: 0.02),
              RaisedButton(
                child: Text('Register'),
                color: Colors.red[600],
                padding: const EdgeInsets.symmetric(horizontal: 135),
                onPressed: () => _validateRegister(),
              ),
              FlatButton(
                child: Text('Back to Login'),
                textColor: Colors.blueGrey,
                onPressed: () => setState(() {
                  isToRegister = false;
                  gradientColor1 = Colors.tealAccent;
                }),
              ),
            ],
          ),
        ));
  }

  Widget loginButtons() {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.9],
              colors: [gradientColor2, gradientColor1])),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              onPressed: () => _googleLogIn(),
              // Navigator.popAndPushNamed(context, '/dashboard'),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              elevation: 5,
            ),
            SignInButton(
              Buttons.Facebook,
              onPressed: () => _facebookLogin(),
              // Navigator.popAndPushNamed(context, '/dashboard'),
              padding: const EdgeInsets.all(5),
              elevation: 5,
            ),
          ],
        ),
      ),
    ));
  }

  _validateLogin() {
    if ((logInEmail.text.length <= 6) && (logInPassword.text.length <= 6)) {
      print('wrong');
      _showMyDialog('Email and password length must be 6 or greater');
    } else {
      _firebaseLogin();
    }
  }

  _validateRegister() {
    if ((registerEmail.text.length <= 8) &&
        (registerPassword.text.length <= 6)) {
      print('wrong');
      _showMyDialog('Email and password length must be 6 or greater');
    } else {
      _firebaseRegister();
    }
  }

  _facebookLogin() async {
    var profile = await AuthManager().signInFb();
    if (profile != null) {
      String imgUrl = profile['picture']['data']['url'];
      String name = profile['name'];

      Router(myContext: context)
          .toDashboard(imgUrl, name, LoginMethod().facebook);
    }
  }

  _googleLogIn() async {
    GoogleSignIn profile = await AuthManager().googleLogin();
    if (profile != null) {
      String imgUrl = profile.currentUser.photoUrl;
      String name = profile.currentUser.displayName;

      Router(myContext: context)
          .toDashboard(imgUrl, name, LoginMethod().google);
    }
  }

  _firebaseLogin() async {
    var profile =
        await AuthManager().firebaseLogin(logInEmail.text, logInPassword.text);
    if (profile.length <= 15) {
      String imgUrl = Constants().photoUrl;
      String name = logInEmail.text;

      Router(myContext: context)
          .toDashboard(imgUrl, name, LoginMethod().firebase);
    } else {
      _showMyDialog(profile.toString());
    }
  }

  _firebaseRegister() async {
    var profile = await AuthManager()
        .firebaseRegister(registerEmail.text, registerPassword.text);
    if (profile.length <= 15) {
      String imgUrl = Constants().photoUrl;
      String name = registerEmail.text;

      Router(myContext: context)
          .toDashboard(imgUrl, name, LoginMethod().firebase);
    } else {
      _showMyDialog(profile.toString());
    }
  }

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
