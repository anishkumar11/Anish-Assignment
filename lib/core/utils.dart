
import 'package:assignment/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/screen_scale_properties.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../configs/app_colors.dart';

class Utils {


  static bool isEmpty(String str) {
    if (str == null || str.length == 0 || str.contains("null")) {
      return true;
    }
    return false;
  }
  static bool StringEqualIgnoreCase(String str1, String str2){
    if(str1.toLowerCase().compareTo(str2.toLowerCase()) == 0){
      return true;
    }
    return false;
  }

  static void closeScreen(BuildContext context){Navigator.pop(context);}


  static void showAssignedJobListScreen(BuildContext context){
    //Navigator.push(context,
      //  new MaterialPageRoute(builder: (context) => new AssignedJobListScreen()));
  }



  static void showToast(BuildContext context, String message){
    if (context!=null) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.colorPrimary,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  static bool validatePhoneNumber(String text) {
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regExp = new RegExp(pattern);

    if(text.length < 6 || text.length > 10){
      return false;
    }else if (!regExp.hasMatch(text)) {
      return false;
    }
    return true;
  }
  static bool validateEmail(String email) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
    return emailValid;
  }

  static void showLoginScreen(BuildContext context){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  static void showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Please wait..." )),
        ],),
    );

    Future.delayed(Duration.zero, () {
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    });
  }

  static void hideLoaderDialog(BuildContext context){
    Future.delayed(Duration.zero, () {
      Navigator.of(context, rootNavigator: true).pop();
    });

  }


  static void initializeScreenScaling(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenScaleProperties(
        width: width, height: height, allowFontScaling: true, allowSubpixel: true);

  }

}
