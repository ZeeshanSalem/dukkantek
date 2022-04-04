// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_style.dart';

class RoundedButton extends StatelessWidget {
  final String text;

  // final Function press;
  final VoidCallback? press;
  final Color color, textColor;
  final double textSize;
  final double width;
  final double height;
  final double verticalPadding;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = primaryColor,
    this.textColor = Colors.white,
    this.textSize = 16,  this.width = double.infinity, this.height = 51, this.verticalPadding = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: press!,
      child: Container(
          width:width,
          height: height,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          decoration: BoxDecoration(
            color: color,
//            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: primaryColor),
          ),
          child: Center(
            child: Text(text, style: latoTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              color: textColor,
              fontSize: textSize,
            ),),
          )
      ),
    );


  }
}