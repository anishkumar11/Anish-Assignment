
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:assignment/configs/app_colors.dart';
import 'package:assignment/configs/local_string.dart';
import 'package:assignment/core/controller/auth/forgot_controller.dart';
import 'package:assignment/core/controller/auth/login_controller.dart';
import 'package:assignment/core/controller/auth/register_controller.dart';
import 'package:assignment/ui/auth/login_screen.dart';
import 'package:assignment/ui/home/home_screen.dart';
import 'package:assignment/ui/splash_screen.dart';

import 'configs/routes.dart';
import 'localization/language_constants.dart';
import 'localization/localization.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _initializeGetX();
    //NotificationService.instance.start();
  }

  void _initializeGetX() {
    Get.put(LoginController());
    Get.put(ForgotController());
    Get.put(RegisterController());
  }

  @override
  Widget build(BuildContext context) {

    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary)),
        ),
      );
    }
    return MaterialApp(
        title: LocalString.kAppName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
            fontFamily: 'Avenir-Next',
            primaryColorLight: AppColors.colorAccent,
            primaryColorDark: AppColors.colorPrimaryDark,
            primaryColor: AppColors.colorPrimary,
            splashColor: AppColors.colorPrimary,
            backgroundColor: Colors.white,
            appBarTheme: new AppBarTheme(
              iconTheme: Theme.of(context).iconTheme,
              backgroundColor: Colors.white,
            ),
            bottomAppBarTheme: const BottomAppBarTheme(
              elevation: 10,
              color: AppColors.colorPrimary,
            )),
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("es", "ES"),
          Locale("hi", "IN"),
          Locale("cn", "ZH"),
          Locale("tw", "ZH"),
        ],
        localizationsDelegates: [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          Routes.home_screen: (BuildContext context) => new HomeScreen(),
          Routes.login_screen: (BuildContext context) => new LoginScreen(),
        });
  }
}

