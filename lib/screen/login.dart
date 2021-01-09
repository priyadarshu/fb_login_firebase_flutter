import 'dart:async';

import 'package:fb_login_firebase_flutter/blocs/auth_bloc.dart';
import 'package:fb_login_firebase_flutter/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:fb_login_firebase_flutter/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Facebook,
              text: "Login into facebook",
              onPressed: () {
                return authBloc.loginFacebook();
              },
              //=> Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => Home(),
            ),
          ],
        ),
      ),
    );
  }
}
