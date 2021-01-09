import 'dart:async';

import 'package:fb_login_firebase_flutter/blocs/auth_bloc.dart';
import 'package:fb_login_firebase_flutter/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<User> homeStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    homeStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: StreamBuilder<User>(
            stream: authBloc.currentUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.data.photoURL + '?width=400&height500'),
                    radius: 60.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    snapshot.data.displayName,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 35.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    snapshot.data.email,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 35.0,
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  SignInButton(
                    Buttons.Facebook,
                    text: "Sign out of Facebook",
                    onPressed: () => authBloc.logOut(),

                    //=> Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => Login(),
                    //   ),
                    // ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
