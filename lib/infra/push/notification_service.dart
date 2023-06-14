import 'dart:convert';
import 'dart:io';

import 'package:assignment/core/constants.dart';
import 'package:assignment/core/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';
import 'notification_bloc.dart';

class NotificationService {
  /// We want singelton object of ``NotificationService`` so create private constructor
  /// Use NotificationService as ``NotificationService.instance``


  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  bool _started = false;

  /// Call this method on startup
  /// This method will initialise notification settings

  void start()  {
    if (!_started)
    {
      _integrateNotification();
      _refreshToken();
      _started = true;
    }
  }

  // Call this method to initialize notification

  void _integrateNotification()  {
    _initializeLocalNotification();
    _registerNotification();

  }

  /// initialize firebase_messaging plugin

  void _registerNotification() {
    FirebaseMessaging.onMessage.listen(
          (message) async {
        print("FCMData::NotificationService::Forground::message = " + message.data.toString());
        _onMessageReceived(message);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      _onLaunch;
      /*showDialog(
        // context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(message.data['title']),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(message.data['Body'])],
                ),
              ),
            );
          });*/
      /*Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));*/
    });

    FirebaseMessaging.instance.onTokenRefresh
        .listen(_tokenRefresh, onError: _tokenRefreshFailure);
  }

  /// Token is unique identity of the device.
  /// Token is required when you want to send notification to perticular user.

  void _refreshToken() {
    FirebaseMessaging.instance.getToken().then((token) async {
      print('token: $token');
      Constants.fcmToken = token!;
    }, onError: _tokenRefreshFailure);
  }

  /// This method will be called device token get refreshed

  void _tokenRefresh(String newToken) async {
    print('New Token : $newToken');
    Constants.fcmToken = newToken;
  }

  void _tokenRefreshFailure(error) {
    print("FCM token refresh failed with error $error");
  }

  /// This method will be called on tap of the notification which came when app was closed

  Future<void> _onLaunch(RemoteMessage message) async {
    print('onLaunch: $message');
    if(Platform.isIOS){
      //message = _modifyNotificationJson(message);
    }
    _performActionOnNotification(message.data);

  }


  void _performActionOnNotification(Map<String, dynamic> message) {
    NotificationsBloc.instance.newNotification(message);
  }

  /// initialize flutter_local_notification plugin

  void _initializeLocalNotification() {
    // Settings for Android
    var androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // Settings for iOS


    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    var iosInitializationSettings = new InitializationSettings();
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android:androidInitializationSettings,
        iOS:initializationSettingsDarwin,
      ),
      //onSelectNotification: _onSelectLocalNotification,
    );
  }

  /// This method will be called on tap of notification pushed by flutter_local_notification plugin when app is in foreground

  Future<String?> _onSelectLocalNotification(String payLoad) async {
    Map data = json.decode(payLoad);
    Map<String, dynamic> message = {
      "data": data,
    };
    _performActionOnNotification(message);
    return null;
  }
}


void _onMessageReceived(RemoteMessage message) {
  onMessageReceived(message, true);
}
void onMessageReceived(RemoteMessage message, bool isShowNotification) {
  //String title = "";
  //String body = "";
  int type = 0,
      orderId = 0;
  if (message.data.containsKey('type')) {
    // Handle data message
    String typeStr = message.data['type'];
    if(!Utils.isEmpty(typeStr)){
      type = int.parse(typeStr);
    }
  }

  if (message.data.containsKey('orderId')) {
    // Handle data message
    String typeStr = message.data['orderId'];
    if(!Utils.isEmpty(typeStr)){
      orderId = int.parse(typeStr);
    }
  }

  print("FCMData::NotificationService::backkground::type = " + type.toString());

  showNotification(message);
}
