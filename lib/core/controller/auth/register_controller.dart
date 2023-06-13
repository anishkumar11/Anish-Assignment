import 'package:assignment/configs/local_string.dart';
import 'package:assignment/core/controller/controller_utils.dart';
import 'package:assignment/core/debug_log.dart';
import 'package:assignment/core/keyboard_utils.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  var processStatus = 0, fetchingCountries = 0, fetchingStates = 0;
  var phoneErrorMsg = "", emailErrorMsg = "",
      fNameErrorMsg = "",lNameErrorMsg = "",
      pwdError = "", confirmPwdError = "",
      errorMsg = "",
      successMsg = "";


  void initializeProcess() {
    resetController();
    update();
  }

  void resetController(){
    processStatus = 0;
    phoneErrorMsg = "";
    emailErrorMsg = "";
    fNameErrorMsg = "";lNameErrorMsg = "";
    pwdError = ""; confirmPwdError = "";
    errorMsg = "";
    successMsg = "";
  }

  void validatePassword(BuildContext context, String text) {
    pwdError = "";
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      pwdError = getTranslated(context, LocalString.required)!;
    }
    update();
  }

  void validateConfirmPassword(BuildContext context, String newPwd, String confirmPwd) {
    confirmPwdError = "";
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(confirmPwd)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      confirmPwdError = getTranslated(context, LocalString.required)!;
    }else if(confirmPwd != newPwd){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      confirmPwdError = getTranslated(context, LocalString.confirm_pwd_error)!;
    }
    update();
  }


  void validateFName(BuildContext context, String text) {
    fNameErrorMsg = "";
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      fNameErrorMsg = getTranslated(context, LocalString.required)!;
    }
    update();
  }

  void validateLName(BuildContext context, String text) {
    lNameErrorMsg = "";
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      lNameErrorMsg = getTranslated(context, LocalString.required)!;
    }
    update();
  }

  void validateEmail(BuildContext context, String text) {
    emailErrorMsg = "";
    DebugLog.printLog("validateEmail::text = $text");
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(text)){
      DebugLog.printLog("validateEmail::match");
      processStatus = ControllerUtils.VALIDATION_ERROR;
      emailErrorMsg = getTranslated(context, LocalString.empty_email)!;
    }else if(!Utils.validateEmail(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      emailErrorMsg = getTranslated(context, LocalString.invalid_email)!;
    }
    update();
  }

  void validatePhone(BuildContext context, String text) {
    phoneErrorMsg = "";
    processStatus = ControllerUtils.IN_PROCESS;
    if(Utils.isEmpty(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      phoneErrorMsg = getTranslated(context, LocalString.required)!;
    }else if(!Utils.validatePhoneNumber(text)){
      processStatus = ControllerUtils.VALIDATION_ERROR;
      phoneErrorMsg = getTranslated(context, LocalString.invalid_phone)!;
    }
    update();
  }


  Future<int> registerAction(BuildContext context,
      String fName,
      String lName,
      String email,
      String phone,
      String pwd,
      String confirmPwd) async {
    KeyboardUtils.closeKeyboard(context);



    DebugLog.printLog("fName = $fName");
    DebugLog.printLog("lName = $lName");
    DebugLog.printLog("email = $email");
    DebugLog.printLog("phone = $phone");
    DebugLog.printLog("pwd = $pwd");
    DebugLog.printLog("confirmPwd = $confirmPwd");


    validateFName(context, fName);
    if(!Utils.isEmpty(fNameErrorMsg)){
      return processStatus;
    }

    validateLName(context, lName);
    if(!Utils.isEmpty(lNameErrorMsg)){
      return processStatus;
    }

    validateEmail(context, email);
    if(!Utils.isEmpty(emailErrorMsg)){
      return processStatus;
    }

    validatePhone(context, phone);
    if(!Utils.isEmpty(phoneErrorMsg)){
      return processStatus;
    }

    validatePassword(context, pwd);
    if(!Utils.isEmpty(pwdError)){
      return processStatus;
    }

    validateConfirmPassword(context, pwd, confirmPwd);
    if(!Utils.isEmpty(confirmPwdError)){
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
        Uri.parse(WebApis.register));


    request.bodyFields = {
      'email': email,
      'mobile': phone,
      'first_name': fName,
      'last_name': lName,
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Utils.hideLoaderDialog(context);
    if (response.statusCode == 200) {
      String resStr = await response.stream.bytesToString();
      print("resStr = $resStr");
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