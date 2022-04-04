// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../core/constants/image_paths.dart';

class ImageContainer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final String assets; /// This is for  local Asset
  final String? url;/// This one is for Network Image,
  final BoxFit fit;
//  final

  const ImageContainer({this.height = 0, this.width = 0, this.assets = ImagePath.loader_image,
    this.radius = 0,
    this.url,
    this.fit = BoxFit.contain,
  });
  @override
  Widget build(BuildContext context) {
    return
      url == null ?
      Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: AssetImage(assets),
              fit: fit,
            )
        ),
      ) : ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: FadeInImage(
          width: width.w,
          height: height.h,
          image: NetworkImage(url!),
          placeholder: AssetImage(assets),
          fit: BoxFit.cover,
        ),
      );
  }
}
