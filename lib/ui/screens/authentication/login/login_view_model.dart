// ignore_for_file: avoid_print


import 'package:flutter/cupertino.dart';

import '../../../../core/enums/view_state.dart';
import '../../../../core/models/app_user.dart';
import '../../../../core/models/custom_auth_result.dart';
import '../../../../core/services/auth_services.dart';
import '../../../../core/services/database_services.dart';
import '../../../../core/view_model/base_view_model.dart';
import '../../locator.dart';


class LoginViewModel extends BaseViewModel {
  AppUser appUser = AppUser();
  final _authService = locator<AuthService>();
  CustomAuthResult authResult = CustomAuthResult();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final dbServices  = DatabaseService();

  ///
  /// Login with Email and Password Functions
  ///

  // ignore: todo
  /// TODO: MAKE SURE WRAP ALL FUNCTION OR LOGIC IN TRY CATCH
  loginWithEmailPassword() async {
    setState(ViewState.loading);
    appUser.email = emailTextEditingController.text;
    appUser.password = passwordTextEditingController.text;
    authResult = await _authService.loginWithEmailPassword(
        email: appUser.email, password: appUser.password);
    setState(ViewState.idle);
  }



  logOutUser() async {
    setState(ViewState.busy);
    try {
      await _authService.logout();

      if (authResult.status!) {
        print("Loguot successful");
      }
    } catch (e, s) {
      print("@AuthViewModel LogOut Exception: $e");
      print(s);
    }
    setState(ViewState.idle);
  }

  updateState(){
    setState(ViewState.busy);
    setState(ViewState.idle);
  }

  loginWithGoogle() async {
    setState(ViewState.busy);
    try{
      authResult = await _authService.signInwithGoogle();

    }catch(e,s){
      print("Login With Google Exception $e ");
      print(s);
    }


    setState(ViewState.idle);
  }

}
