
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/screen_scale_properties.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:assignment/configs/app_colors.dart';

import 'package:assignment/configs/assets_images.dart';
import 'package:assignment/core/utils.dart';

class CommonWidgetUtils {

  static Widget getLabelSingleLine(String text, double
  fontsize,
      FontWeight fontWeight,
      Color textColor) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        //fontSize: fontsize,
          fontSize: ScreenScale.convertFontSize(fontsize,
              allowFontScaling: true),
          color: textColor,
          fontStyle: FontStyle.normal,
          fontWeight: fontWeight),
    );
  }

  static Widget getLabelItalicSingleLine(String text, double
  fontsize,
      FontWeight fontWeight,
      Color textColor) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        //fontSize: fontsize,
          fontSize: ScreenScale.convertFontSize(fontsize,
              allowFontScaling: true),
          fontStyle: FontStyle.italic,
          color: textColor,
          fontWeight: fontWeight),
    );
  }

  static Widget getSeparator(double paddingTop, double paddingLeft,
      double PaddingRight, double paddingBottom,
      Color color, double height) {
    return Padding(
        padding: EdgeInsets.only(top: paddingTop, left: paddingLeft, right: PaddingRight),
        child: Divider(
          color: color,
          thickness: height,
        ));
  }

  static Widget getSeparator2(Color color, double height) {
    return Divider(
      color: color,
      height: height,
    );
  }
  static Widget getSeparator3(Color color, double height) {
    return Divider(
      color: color,
      height: convertHeight(height),
    );
  }
  static Widget getLabel2(String text, double
  fontsize,
      FontWeight fontWeight,
      Color textColor) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
        //fontSize: fontsize,
          fontSize: ScreenScale.convertFontSize(fontsize,
              allowFontScaling: true),
          color: textColor,
          fontStyle: FontStyle.normal,
          fontWeight: fontWeight),
    );
  }

  static Widget getLabel3(String text, double
  fontsize,
      FontWeight fontWeight,
      Color textColor) {
    return Text(
      text,
      style: TextStyle(
        //fontSize: fontsize,
          fontSize: ScreenScale.convertFontSize(fontsize,
              allowFontScaling: true),
          color: textColor,
          fontWeight: fontWeight),
    );
  }

  static Widget getCenterTextLabel(String text, double
  fontsize,
      FontWeight fontWeight,
      Color textColor) {
    return Text(
      text,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        //fontSize: fontsize,
          fontSize: ScreenScale.convertFontSize(fontsize,
              allowFontScaling: true),
          color: textColor,
          fontStyle: FontStyle.normal,
          fontWeight: fontWeight),
    );
  }

  static Widget getCenterTextItalicLabel(String text, double
  fontsize,
      FontWeight fontWeight,
      Color textColor) {
    return Text(
      text,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        //fontSize: fontsize,
          fontSize: ScreenScale.convertFontSize(fontsize,
              allowFontScaling: true),
          fontStyle: FontStyle.italic,
          color: textColor,
          fontWeight: fontWeight),
    );
  }

  static Widget getImageView(String path, double imgWidth, double imgHeight) {
    if(path.toLowerCase().startsWith("http")) {
      return CachedNetworkImage(
        imageUrl: path,
        width: imgWidth,
        height: imgHeight,
        placeholder: (context, url) => CircularProgressIndicator(
          color: Colors.white70,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.white,),
      );
      /*return Image.network(
        path,
        fit: BoxFit.contain,
        width: imgWidth,
        height: imgHeight,
      );*/
    }
    return Image.asset(
      path,
      fit: BoxFit.contain,
      width: imgWidth,
      height: imgHeight,
    );
  }

  static Widget getImageView2(String path) {
    if(path.toLowerCase().startsWith("http")) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.cover,
        placeholder: (context, url) => CircularProgressIndicator(
          color: Colors.white70,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.white,),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
    );
  }

  static Widget getRoundCornerImage(String path, double cornerRadius) {
    if(path.toLowerCase().startsWith("http")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: CachedNetworkImage(imageUrl: "https://media.istockphoto.com/id/1334542399/photo/elopement-wedding.jpg?s=1024x1024&w=is&k=20&c=pkGoOaMfa28tu9xa6r_LJO-Vhtq_HQ62saZ0DpmDVFk=",
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
    );


  }

  static Widget getVerticalLine(double height, double thickness, Color color) {
    double coldividerWidth = CommonWidgetUtils.convertWidth(1);
    return Container(
      width: thickness,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            left: BorderSide( //                   <--- left side
              color: color,
              width: thickness,
            ),
            right: BorderSide( //                    <--- top side
              color: Colors.transparent,
              width: 0.0,
            ),
            top: BorderSide( //                   <--- left side
              color: Colors.transparent,
              width: 0.0,
            ),
            bottom: BorderSide( //                    <--- top side
              color: Colors.transparent,
              width: 0.0,
            ),
          )
      ),
    );
  }

  static Widget getVerticalLine2(double height, double thickness, Color color) {
    height = CommonWidgetUtils.convertHeight(height);
    thickness = CommonWidgetUtils.convertWidth(thickness);

    return Container(
      width: thickness,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            left: BorderSide( //                   <--- left side
              color: color,
              width: thickness,
            ),
            right: BorderSide( //                    <--- top side
              color: Colors.transparent,
              width: 0.0,
            ),
            top: BorderSide( //                   <--- left side
              color: Colors.transparent,
              width: 0.0,
            ),
            bottom: BorderSide( //                    <--- top side
              color: Colors.transparent,
              width: 0.0,
            ),
          )
      ),
    );
  }

  static Widget getHorizontalLine(double thickness, Color color) {
    thickness = CommonWidgetUtils.convertWidth(thickness);

    return Divider(
        color: color,
        height: 0,
        thickness: thickness);
  }

  static Widget getVerticalSpace(double height) {
    return SizedBox(height: ScreenScale.convertHeight(height));
  }

  static Widget getHorizontalSpace(double width) {
    return SizedBox(width: ScreenScale.convertWidth(width));
  }

  static double convertHeight(double height) {
    return ScreenScale.convertHeight(height);
  }

  static double convertWidth(double width) {
    return ScreenScale.convertWidth(width);
  }



  
}