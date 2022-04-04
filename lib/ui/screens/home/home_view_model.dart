// ignore_for_file: avoid_print



import 'package:dukkantek/core/models/cat_fact.dart';
import 'package:dukkantek/ui/screens/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/enums/view_state.dart';
import '../../../core/services/auth_services.dart';
import '../../../core/services/database_services.dart';
import '../../../core/view_model/base_view_model.dart';
import '../splash/splash_screen.dart';

class HomeViewModel extends BaseViewModel{

  final auth = locator<AuthService>();
  final dbServices = DatabaseService();
  CatFact? catFact;

  HomeViewModel(){
    getCatFact();
  }

  getCatFact() async{
    setState(ViewState.loading);
    try{
      catFact = await dbServices.getCatFact();
    }catch(e,s){
      debugPrint("Home ViewModel getCatFact() Exception $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);

  }

  logout() async{
    setState(ViewState.loading);
    try{
      await auth.logout();
      Get.offAll(()=> SplashScreen());
    }catch(e,s){
      debugPrint("Home ViewModel logout Exception $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }



}