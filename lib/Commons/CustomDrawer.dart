import 'package:EigitalFacebook/Helpers/Responsive.dart';
import 'package:EigitalFacebook/Router.dart';
import 'package:EigitalFacebook/Services/AuthManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:EigitalFacebook/Constants/LoginMethod.dart';

class CustomDrawer extends StatelessWidget {
  final String imageUrl;
  final String fbName;
  final String media;

  @override
  CustomDrawer(
      {@required this.imageUrl, @required this.fbName, @required this.media});

  Widget build(BuildContext context) {
    logOutFb() async {
      await AuthManager().signOutFb(context);
      Router(myContext: context).toLogin();
    }

    logOutGoogle() async {
      await AuthManager().googleLogout();
      Router(myContext: context).toLogin();
    }

    logOutFirebase() async {
      await AuthManager().firebaseLogOut();
      Router(myContext: context).toLogin();
    }

    Widget logOutUI() {
      if (media == LoginMethod().facebook) {
        return SignInButton(
          Buttons.Facebook,
          onPressed: () => logOutFb(),
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          elevation: 10,
          text: 'Sign out',
        );
      } else if (media == LoginMethod().google) {
        return SignInButton(
          Buttons.Google,
          onPressed: () => logOutGoogle(),
          padding: const EdgeInsets.symmetric(horizontal: 80),
          elevation: 10,
          text: 'Sign out',
        );
      } else if (media == LoginMethod().firebase) {
        return SignInButton(
          Buttons.Email,
          onPressed: () => logOutFirebase(),
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          elevation: 10,
          text: 'Sign out',
        );
      }
    }

    return Drawer(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: dh(context) * 0.1,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              //+ '?width=500&height500'
              radius: 60,
            ),
            SizedBox(
              height: dh(context) * 0.1,
            ),
            Text(
              fbName,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: dh(context) * 0.45,
            ),
            logOutUI(),
          ],
        ),
      ),
    );
  }
}
