
import 'package:flutter/material.dart';

class AppColors {


  static const Color colorPrimary = Color(0xFF01478d),//Color(0xFFDAAD39),
      colorPrimaryDark = Color(0xFF01478d),
      colorAccent = Color(0xFF01478d),
      splashBgColor  = Color(0xFFFFFFFF),
      splashBgColor1 = Color(0xFFECDBA4),
      splashBgColor2 = Color(0xFFDAAD39),
      bottomBarColor = Color(0xF0FFFFFF),
      appBarBgColor = Color(0xFFEFF3F6),
      appBarBackgrounColor2 = Color(0xFFEFF3F6),
      backgroundColor = Color(0xFFEFF3F6),
      iconColor = Color(0xFF062947),
      ratingColor = Color(0xFFE7AF3A),
      yellowColor = Color(0xFFfad02c),
      iconColorLightBlue = Color(0xFF6C97DB),
      colorLightGreen = Color(0xFFE6F2FF),
      colorPostText = Color(0xFF062947),
      colorBlack = Colors.black,
      colorBlack2 = Color(0xFF2F2F2F),
      colorBlack3 = Color(0xFF555555),
      colorBlack4 = Color(0xFF424242),
      colorGrey = Color(0xFF8A8A8A),
      colorGrey2 = Color(0xFF989898),
      colorGrey3 = Color(0xFFEDEDED),
      colorGrey4 = Color(0xFFEEEEEE),
      colorGrey5 = Color(0xFFB4B4B4),
      colorGrey6 = Color(0xFFE2E2E2),
      colorGrey7 = Color(0xFFF8F8F8),
      colorGrey8 = Color(0xFFFAFAFA),
      colorGrey9 = Color(0xFFC8C8C8),

      colorLightGrey = Color(0xFFDFDFDF),
      colorPostDarkText = Color(0xFF132836),
      colorTextDarkGrey = Color(0xFF484848),
      colorGreen = Color(0xFF65C77F),
      backgroundColorGreen = Color(0xFFf4faff),
      blueColor = Color(0xFF01478d),
      lightBlueColor = Color(0xFF637d9b),
      colorSeparator = Colors.grey,
      darkRedColor = Color(0xffc91323);



  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

}
