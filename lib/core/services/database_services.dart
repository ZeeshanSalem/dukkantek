// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dukkantek/core/constants/end_points.dart';
import 'package:dukkantek/core/models/cat_fact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../models/app_user.dart';
import 'api_services.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  FirebaseAuth auth = FirebaseAuth.instance;

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  ///
  /// Register User
  ///
  registerUser(AppUser user) async {
//    print(user.id.toString() + "ID is ssss-------");
    try {
      await _db.collection('reg_user').doc(user.uid).set(user.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerUser $e');
      // ignore: avoid_print
      print(s);
    }
  }

  ///
  /// Get User
  ///
  Future<AppUser?> getUser(id) async {
    print('@getUser: id: $id');
    try {
      final snapshot = await _db.collection('reg_user').doc(id).get();
//      debugPrint('User Data: ${snapshot.data()}');
      return AppUser.fromJson(
          snapshot.data() as Map<String, dynamic>, snapshot.id);
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getUser $e');
      print(s);
      return null;
    }
  }


  ///
  /// ============================  Api Function Start from here ==========================
  ///

  Future<CatFact?> getCatFact() async{
    CatFact? catFact;
    try{
      Dio dio = ApiServices().launch();

      final response = await dio.get(EndPoints.catFacts);


      if(response.statusCode == 200){
        debugPrint("${response.data.toString()}");
        catFact = CatFact.fromJson(response.data);
      }


    }catch(e,s){
      debugPrint('Exception @loginUserWithServer $e');
      print(s);
      return null;
    }
    return catFact;
  }


}
