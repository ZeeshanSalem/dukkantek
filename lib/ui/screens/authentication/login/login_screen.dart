// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names


import 'package:dukkantek/core/constants/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_style.dart';
import '../../../../core/enums/view_state.dart';
import '../../../custom_widgets/buttons/rounded_button.dart';
import '../../../custom_widgets/image_container.dart';
import '../../../custom_widgets/text_fields/input_text_field.dart';
import '../../home/home_screen.dart';
import '../registration_step1/registration_screen_01.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: Consumer<LoginViewModel>(builder: (context, model, child) {
          return ModalProgressHUD(
            color: primaryColor,
            inAsyncCall: model.state == ViewState.loading,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  "LogIn",
                  style: latoTextStyle.copyWith(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        Text(
                          "Dukkantek Connect With Us",
                          style: latoTextStyle.copyWith(
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        InputTextField(
                          controller: model.emailTextEditingController,
                          hintText: "Email",
                          onChanged: (String? val) {
                            model.appUser.email = val;
                            model.updateState();
                          },
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        InputTextField(
                          controller: model.passwordTextEditingController,
                          hintText: "Password",
                          onChanged: (String? val) {
                            model.appUser.password = val;
                            model.updateState();
                          },
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        RoundedButton(
                            width: double.infinity,
                            press: () async {
                              if (_formKey.currentState!.validate()) {
                                await model.loginWithEmailPassword();

                                if (model.authResult.status!) {
                                  Get.offAll(() => HomeScreen());
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Invalid credentials'),
                                      content: Text(
                                          'invalid credential, please try again'),
                                    ),
                                  );
                                }
                              }
                            },
                            text: "Login"),
                        SizedBox(
                          height: 10.h,
                        ),

                        GestureDetector(
                          onTap: () async {
                            await model.loginWithGoogle();
                            if (model.authResult.status!) {
                              Get.offAll(() => HomeScreen());

                            } else {
                              // ignore: avoid_print
                              print('.......login failed.....');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Login Error'),
                                    content: Text(model.authResult
                                        .errorMessage ??
                                        'Login Failed'),
                                  );
                                },
                              );
                              ;
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: ScreenUtil().setHeight(44),
                                width: ScreenUtil().setWidth(44),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImagePath.google,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              SizedBox(width: 14.w,),
                              Text("Sign With Google", style: latoTextStyle.copyWith(fontSize: 15.sp),),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => RegistrationScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'Go to Sign Up',
                                style: latoTextStyle.copyWith(
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),

    );
  }
}
