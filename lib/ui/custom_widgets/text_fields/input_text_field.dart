// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/text_style.dart';

class InputTextField extends StatelessWidget {
  final String? hintText;
  final bool isPasswordActive;
  final  validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputAction inputAction;
  final  onChanged;
  final  onSave;
  final VoidCallback? onTap;
  final int? maxLine;
  final TextInputType? inputType;
  final bool isReadOnly;
  final LengthLimitingTextInputFormatter? limitingTextInputFormatter;
  const InputTextField({this.hintText, this.controller, this.limitingTextInputFormatter,
  this.onTap, this.onChanged, this.onSave, this.inputAction = TextInputAction.next,
    this.inputType= TextInputType.emailAddress, this.isPasswordActive = false, this.maxLine = 1, this.prefixIcon, this.isReadOnly = false,
  this.suffixIcon, this.validation});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      inputFormatters: [
        limitingTextInputFormatter != null ? limitingTextInputFormatter! : LengthLimitingTextInputFormatter(300),
      ],
      readOnly: isReadOnly,
      onTap: onTap ?? (){},
      onChanged: onChanged,
      onFieldSubmitted: onSave,
      validator: validation,
      controller: controller == null ?TextEditingController(): controller!,
      obscureText: isPasswordActive,
      textInputAction: inputAction,
      keyboardType: inputType!,
      maxLines: maxLine,
      cursorColor: Colors.black,

      style: latoTextStyle.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 15.sp,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,

        hintStyle: latoTextStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 15.sp,
          color: Colors.grey,
        ),
        labelText: hintText,
        labelStyle: latoTextStyle.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 15.sp,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        suffixIcon: suffixIcon == null ? Container(width: 1.w,) : Padding(
          padding:  EdgeInsets.only(right:10.0),
          child: suffixIcon!,
        ),
        suffixIconConstraints: BoxConstraints(
          maxWidth: 35.w,
          maxHeight: 35.h,
        ),
//        prefix: prefixIcon == null ? Container() : prefixIcon!,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.r),
            borderSide: BorderSide(
              color: Colors.grey,
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28.r),
            borderSide: BorderSide(
              color: Colors.grey,
            )
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.r),
          borderSide: BorderSide(
              color: Colors.grey,
            ),

        ),
      ),

    );
  }
}
