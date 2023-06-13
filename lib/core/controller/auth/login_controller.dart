import 'dart:convert';

import 'package:assignment/core/controller/controller_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:assignment/configs/local_string.dart';
import 'package:assignment/core/keyboard_utils.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/infra/network/web_apis.dart';
import 'package:assignment/localization/language_constants.dart';

class LoginController extends GetxController {
  var processStatus = 0;
  var emailError = "", pwdError = "",
      successMsg = "";

  void initializeProcess() {
    processStatus = 0;
    emailError = "";
    pwdError = "";
    successMsg = "";
    update();
  }

  void validateEmail(BuildContext context, String text) {
    emailError = "";
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      emailError = getTranslated(context, LocalString.empty_email)!;
    }else if(!Utils.validateEmail(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      emailError = getTranslated(context, LocalString.invalid_email)!;
    }
    update();
  }

  void validatePassword(BuildContext context, String text) {
    pwdError = "";
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      pwdError = getTranslated(context, LocalString.empty_pwd)!;
    }
    update();
  }



  Future<int> loginAction(BuildContext context, String email, String pwd) async {
    KeyboardUtils.closeKeyboard(context);
    validateEmail(context, email);
    if(!Utils.isEmpty(emailError)){
      processStatus = ControllerUtils.ERROR;
      return processStatus;
    }
    validatePassword(context, pwd);
    if(!Utils.isEmpty(pwdError)){
      processStatus = ControllerUtils.ERROR;
      return processStatus;
    }
    processStatus = ControllerUtils.SUCCESS;
    return processStatus;

    /*Utils.showLoaderDialog(context);
    int resultCode = IN_PROCESS;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST',
        Uri.parse(WebApis.login));
    request.bodyFields = {
      'email': email,
      'password':pwd
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Utils.hideLoaderDialog(context);
    if (response.statusCode == 200) {
      String resStr = await response.stream.bytesToString();
      var tagObjsJson = jsonDecode(resStr);
      if(tagObjsJson["error"] == 1){
        emailError = tagObjsJson["message"];
        resultCode = ERROR;
        processStatus = resultCode;
        update();
      }else {
        resultCode = SUCCESS;
        successMsg = tagObjsJson["message"];
        User user = ResponseParser.parseUserData(resStr);
        AppData.saveUser(user);
      }
    }
    else {
      resultCode = FAILED;
      processStatus = resultCode;
      update();
      //print(response.reasonPhrase);
    }

    return resultCode;*/
  }
}