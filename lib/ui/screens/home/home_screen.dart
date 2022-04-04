
import 'package:dukkantek/core/enums/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_style.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder:(context, model, child)=>
            Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: primaryColor,
            title: Text("DUKKANTEK", style: latoTextStyle.copyWith(color: Colors.white),),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () async{
                    await model.logout();
                  },
                  icon: Icon(Icons.logout_outlined, size: 25.sp, color: Colors.white,)),
            ],
          ),
          body: model.state == ViewState.loading ? const Center(
            child: CircularProgressIndicator(color: primaryColor,),
          ):Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hello ${model.auth.appUser?.email}", style: latoTextStyle,),


               model.catFact != null ?
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                 child: Text("${model.catFact?.fact}", style: latoTextStyle,),
               ) : Container(),
              ],
            ),
          ),
            ),
        ),
    );
  }

}
