
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/app_user.dart';
import '../models/custom_auth_result.dart';
import 'auth_exceptional_services.dart';
import 'database_services.dart';

class AuthService {
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;
  CustomAuthResult customAuthResult = CustomAuthResult();
  User? user;
  bool? isLogin;
  AppUser? appUser;

  AuthService() {
    init();
  }

  init() async {
    user = _auth.currentUser;
    if (user != null) {
      debugPrint(user!.uid);
      isLogin = true;
      appUser = await _dbService.getUser(user!.uid);

      //debugPrint("${appUser!.toJson()}");
    } else {
      isLogin = false;
    }
  }

  Future<CustomAuthResult> signUpWithEmailPassword(AppUser user) async {
    print('@services/singUpWithEmailPassword');
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      /// If user login fails without any exception and error code
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }

      if (credentials.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        user.uid = credentials.user!.uid;

        await _dbService.registerUser(user);
        this.appUser = user;
      }
    } catch (e) {
      print('Exception @sighupWithEmailPassword: $e');
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  Future<CustomAuthResult> loginWithEmailPassword({email, password}) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
      }

      ///
      /// If firebase auth is successful:
      ///
      /// Check if there is a user account associated with
      /// this uid in the database.
      /// If yes, then proceed to the auth success otherwise
      /// logout the user and generate an error for the user.
      ///
      if (credentials.user != null) {
        appUser = (await _dbService.getUser(credentials.user!.uid))!;

        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
      }
    } catch (e) {
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  Future<CustomAuthResult> signInwithGoogle() async {
    try {

      final GoogleSignInAccount? googleSignInAccount =
      await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

     final credentials = await _auth.signInWithCredential(authCredential);

      /// If user login fails without any exception and error code
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }

      if (credentials.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        AppUser user1 = AppUser(
          uid: credentials.user?.uid,
          email: googleSignInAccount?.email,
          firstName: googleSignInAccount?.displayName,
        );


        await _dbService.registerUser(user1);
        this.appUser = user1;
        customAuthResult.status = true;

      }

    } catch (e,s) {
      customAuthResult.status = false;
      customAuthResult.errorMessage = "$e";

    }
    return customAuthResult;
  }


  Future<void> logout() async {
    await _auth.signOut();
    isLogin = false;
    appUser = null;
    user = null;
  }
}
