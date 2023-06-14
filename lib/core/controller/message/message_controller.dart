import 'dart:convert';

import 'package:assignment/core/constants.dart';
import 'package:assignment/core/controller/controller_utils.dart';
import 'package:assignment/core/debug_log.dart';
import 'package:assignment/core/keyboard_utils.dart';
import 'package:assignment/core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MessageController extends GetxController {
  var processStatus = 0;
  var errorMsg = "", successMsg = "";

  void initializeProcess() {
    resetController();
    update();
  }

  void resetController(){
    processStatus = 0;
    errorMsg = "";
    successMsg = "";
  }


  Future<int> sendMessage(BuildContext context, String message) async {
    KeyboardUtils.closeKeyboard(context);
    if(Utils.isEmpty(message)){
      processStatus = ControllerUtils.ERROR;
      return processStatus;
    }

    Utils.showLoaderDialog(context);
    int resultCode = ControllerUtils.IN_PROCESS;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAq4HoerA:APA91bHw96ic_HLAsQ2JQiqNy9BNs8fot1Zos7HI18toI98OCt1ohomVQuHimm8lpGHuv3Ol1W32oeUGvMXMl-Wi5i41OAxUcY9XsavL-EcRGvnm_GoT7HDJj41xVktMbpyVIRJxJm17'
    };
    var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": Constants.fcmToken,
      "notification": {
        "title": "Check this Mobile (title)",
        "body": "Rich Notification testing (body)",
        "mutable_content": true,
        "sound": "Tri-tone"
      },
      "data": {
        "title": "New Message",
        "description": message
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    Utils.hideLoaderDialog(context);
    if (response.statusCode == 200) {
      String resStr = await response.stream.bytesToString();
      var tagObjsJson = jsonDecode(resStr);
      if(tagObjsJson["success"] == 1){
        successMsg = "Message sent";
        resultCode = ControllerUtils.SUCCESS;
        processStatus = resultCode;
        update();
      }else {
        resultCode = ControllerUtils.ERROR;
        errorMsg = "Something went wrong!";
      }
    }
    else {
      resultCode = ControllerUtils.FAILED;
      processStatus = resultCode;
      update();
      //print(response.reasonPhrase);
    }

    return resultCode;
  }
}