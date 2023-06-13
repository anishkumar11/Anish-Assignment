import 'dart:async';

import 'package:assignment/configs/app_colors.dart';
import 'package:assignment/configs/assets_images.dart';
import 'package:assignment/configs/routes.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double logoDim = (37*MediaQuery.of(context).size.height)/100;

    return Scaffold(
      backgroundColor: AppColors.splashBgColor,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CommonWidgetUtils.getImageView(AssetsImages.app_logo, logoDim, logoDim),
            ],
          )),);
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, _navigationPage);
  }

  void _navigationPage() {
    Navigator.of(context).pushReplacementNamed(Routes.login_screen);

  }

}
