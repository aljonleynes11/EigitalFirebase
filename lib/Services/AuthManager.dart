import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Router.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> signInFb() async {
    FacebookLogin facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      final token = result.accessToken.token;
      final graphResponse = await get(
          'https://graph.facebook.com/v2.12/me?fields=picture.width(800).height(800),name,first_name,last_name,email&access_token=${token}');
      final profile = json.decode(graphResponse.body);
      final credential = FacebookAuthProvider.credential(token);
      _auth.signInWithCredential(credential);

      return profile;
    } else if (result.status == FacebookLoginStatus.cancelledByUser) {
      print('please login');
    }
  }

  signOutFb(context) async {
    FacebookLogin facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _auth.signOut();
    return 'ready to logout';
  }

//
// google login start
//
  GoogleSignIn google = GoogleSignIn(scopes: ['email']);
  Future<GoogleSignIn> googleLogin() async {
    try {
      await google.signIn();
      return google;
    } catch (e) {
      print(e);
    }
  }

  googleLogout() async {
    try {
      await google.signOut();
    } catch (e) {
      print(e);
    }
  }

//
// firebase register
//
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> firebaseLogin(email, password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'signed in';
    } on FirebaseException catch (e) {
      print(e);
      return 'Invalid credentials, Please try again';
    }
  }

  Future<String> firebaseRegister(email, password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'registered';
    } on FirebaseException catch (e) {
      print(e);
      return 'User already registered, Please try different email';
    }
  }

  Future<String> firebaseLogOut() async {
    await _firebaseAuth.signOut();
    return 'signed out';
  }
}
