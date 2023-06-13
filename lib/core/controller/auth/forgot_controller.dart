import 'package:assignment/configs/local_string.dart';
import 'package:assignment/core/controller/controller_utils.dart';
import 'package:assignment/core/keyboard_utils.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  var processStatus = 0;
  var errorMsg = "", successMsg = "";

  void initializeProcess() {
    processStatus = 0;
    errorMsg = "";
    successMsg = "";
    update();
  }

  void validateEmail(BuildContext context, String text) {
    errorMsg = "";
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(text)){
      processStatus = ControllerUtils.ERROR;
      errorMsg = getTranslated(context, LocalString.empty_email)!;
    }else if(!Utils.validateEmail(text)){
      processStatus = ControllerUtils.ERROR;
      errorMsg = getTranslated(context, LocalString.invalid_email)!;
    }
    update();
  }



  Future<int> forgotPwdAction(BuildContext context, String email) async {
    KeyboardUtils.closeKeyboard(context);
    validateEmail(context, email);
    if(!Utils.isEmpty(errorMsg)){
      processStatus = ControllerUtils.ERROR;
      return processStatus;
    }

    processStatus = ControllerUtils.SUCCESS;
    return processStatus;

    /*Utils.showLoaderDialog(context);
    int resultCode = ControllerUtils.IN_PROCESS;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST',
        Uri.parse(WebApis.forgotPassword));
    request.bodyFields = {
      'email': email
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Utils.hideLoaderDialog(context);
    if (response.statusCode == 200) {
      String resStr = await response.stream.bytesToString();
      var tagObjsJson = jsonDecode(resStr);
      if(tagObjsJson["error"] == 1){
        errorMsg = tagObjsJson["message"];
        resultCode = ControllerUtils.ERROR;
        processStatus = resultCode;
        update();
      }else {
        resultCode = ControllerUtils.SUCCESS;
        successMsg = tagObjsJson["message"];
      }
    }
    else {
      resultCode = ControllerUtils.FAILED;
      processStatus = resultCode;
      update();
      //print(response.reasonPhrase);
    }

    return resultCode;*/
  }
}