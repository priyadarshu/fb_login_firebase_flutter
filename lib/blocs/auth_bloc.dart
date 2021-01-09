import 'package:fb_login_firebase_flutter/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User> get currentUser => authService.currenUser;
  loginFacebook() async {
    print('starting facebook login');

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        print('It worked');

        //Get token
        final FacebookAccessToken fbToken = res.accessToken;

        // convert it to auth credential

        final AuthCredential credential =
            FacebookAuthProvider.credential(fbToken.token);

        // user credential to signin withfirebase
        final result = await authService.signInWithCredential(credential);
        print('${result.user.displayName} is now logged in');

        break;
      case FacebookLoginStatus.cancel:
        print('The user cancelled the login');
        break;
      case FacebookLoginStatus.error:
        print('There as an error');
        break;
    }
  }

  logOut() {
    authService.logOut();
  }
}
