// ignore_for_file: use_key_in_widget_constructors


import 'package:dukkantek/ui/screens/authentication/registration_step1/registration_screen_01_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_style.dart';
import '../../../../core/enums/view_state.dart';
import '../../../custom_widgets/buttons/rounded_button.dart';
import '../../../custom_widgets/text_fields/input_text_field.dart';
import '../../home/home_screen.dart';

class RegistrationScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegistrationScreenViewModel(),
      child: Consumer<RegistrationScreenViewModel>(
        builder: (context, model, child)=> ModalProgressHUD(
          color: primaryColor,
          inAsyncCall: model.state == ViewState.loading,
          child: Scaffold(
            backgroundColor: backgroundColor,

            appBar: AppBar(
              backgroundColor: primaryColor,
              centerTitle: true,
              title: Text("Registration",
                style: latoTextStyle.copyWith(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),),
            ),

            body: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 30),

              child: Form(
                key: _formKey,
                child: Column(
                  children: [

                    Text("Register your self for connecting.",
                      style: latoTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),),
                    SizedBox(
                      height: 30.h,
                    ),


                    InputTextField(
                      validation: (String? val){
                        if(val!.isEmpty || val.length < 1){
                          return "Please Enter First Name";
                        } else{
                          return null;
                        }
                      },
                      controller: model.firstNameController,
                      hintText: "First Name",
                      onChanged: (String? val){
                        model.user.firstName  = val;
                        model.updateState();
                      },
                    ),

                    SizedBox(height: 10.h,),

                    InputTextField(
                      validation: (String? val){
                        if(val!.isEmpty || val.length < 1){
                          return "Please Enter Email";
                        } else{
                          return null;
                        }
                      },
                      controller: model.emailController,
                      hintText: "Email",
                      onChanged: (String? val){
                        model.user.email  = val;
                        model.updateState();
                      },
                    ),

                    SizedBox(height: 10.h,),



                    InputTextField(
                      validation: (String? val){
                        if(val!.isEmpty || val.length < 1){
                          return "Please Enter Password";
                        } else{
                          return null;
                        }
                      },
                      inputType: TextInputType.visiblePassword,

                      isPasswordActive: true,
                      controller: model.passwordController,
                      hintText: "Password",
                      onChanged: (String? val){
                        model.user.password  = val;
                        model.updateState();
                      },
                    ),

                    SizedBox(height: 10.h,),

                    InputTextField(
                      validation: (String? val){
                        if(val!.isEmpty || val.length < 1){
                          return "Please Enter Confirm Password";
                        } else{
                          return null;
                        }
                      },
                      inputType: TextInputType.visiblePassword,
                      isPasswordActive: true,
                      controller: model.confirmPasswordController,
                      hintText: "Confirm Password",
                      onChanged: (String? val){
                        model.user.confirmPassword  = val;
                        model.updateState();
                      },
                    ),

                    SizedBox(height: 10.h,),


                    RoundedButton(
                        width: double.infinity,
                        press: () async {
                          if (_formKey.currentState!.validate()) {
//                          print("Register User");
                            await model.registerUserFirsbase();

//                        Get.to(() => RegistrationScreen2(appUser: model.user));
//                          await model.createAccount();
                            if (model.authResult.status!) {
                              Get.offAll(() =>  HomeScreen());
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Invalid Credential,'),
                                  content: Text(
                                      model.authResult.errorMessage ??
                                          'Invalid Credential, Please try again'),
                                ),
                              );
                            }
                          }
                        },
                        text: "Register"),






                  ],
                ),
              ),
            ),



          ),
        ),
      ),
    );
  }
}
