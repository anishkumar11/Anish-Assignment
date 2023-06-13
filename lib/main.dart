import 'dart:convert';
import 'dart:math';

import 'package:assignment/configs/app_colors.dart';
import 'package:assignment/core/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'infra/push/notification_service.dart';
import 'my_app.dart';

const String channel_key= "assignment_2023",
    channel_name = "Assignment";


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  onMessageReceived(message, true);
}

// Build main of app(start) including device preview multiple devices.
void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.colorPrimary,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_){
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );
  });

}

Future<void> _initializeFirebase() async{
  await Firebase.initializeApp();
}


const AndroidNotificationChannel androidPlatformChannelSpecifics = AndroidNotificationChannel(
  channel_key, // id
  channel_name, // name
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initFireBase() async {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidPlatformChannelSpecifics);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  NotificationService.instance.start();
}

void onMessageReceived(RemoteMessage message, bool isShowNotification) {
  //String title = "";
  //String body = "";
  print("message = $message");
  int type = 0,
      orderId = 0;
  if (message.data.containsKey('type')) {
    // Handle data message
    String typeStr = message.data['type'];
    if(!Utils.isEmpty(typeStr)){
      type = int.parse(typeStr);
    }
  }
  print("FCMData::Main::backkground::type = " + type.toString());

  showNotification(message, type, orderId, isShowNotification);
}

void showNotification(RemoteMessage message, int type, int orderId, bool isShowNotification) {
  showNotificationAlert(message);
}

void showNotificationAlert(RemoteMessage message) async {

  /*createNotification(message.data['title'],
        message.data['Body']);*/
  var androidNotificationDetails = new AndroidNotificationDetails(
      channel_key,
      channel_name,
      importance:Importance.high
  );
  //var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidNotificationDetails,
    //iOS: iOSPlatformChannelSpecifics
  );

  //print("setting notifi ation*****");
  await flutterLocalNotificationsPlugin.show(
    Random().nextInt(2147483647),
    message.data['title'],
    message.data['description'],
    platformChannelSpecifics,
    payload: json.encode(message.data,),
  );
}

