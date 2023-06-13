import 'package:assignment/core/controller/controller_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/flutter_screen_scaling.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:assignment/configs/app_colors.dart';
import 'package:assignment/configs/assets_images.dart';
import 'package:assignment/configs/local_string.dart';
import 'package:assignment/core/constants.dart';
import 'package:assignment/core/controller/auth/register_controller.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/localization/language_constants.dart';
import 'package:assignment/ui/auth/login_screen.dart';
import 'package:assignment/ui/home/home_screen.dart';
import 'package:assignment/widgets/common_widget_utils.dart';

class RegistrationScreen extends StatefulWidget {

  RegistrationScreen(){
  }

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final RegisterController _stateController = Get.find<RegisterController>();

  final TextEditingController
      _fNameEditingController = TextEditingController(),
      _lNameEditingController = TextEditingController(),
      _emailEditingController = TextEditingController(),
      _pwdEditingController = TextEditingController(),
      _confirmpwdEditingController = TextEditingController(),
      _phoneEditingController = TextEditingController();

  int INPUT_TYPE_EMAIL = 1, INPUT_TYPE_PWD = 2,
      INPUT_TYPE_PHONE = 3, INPUT_TYPE_CONFIRM_PWD = 4,
      INPUT_TYPE_NAME = 5,
      INPUT_TYPE_FNAME = 7,INPUT_TYPE_LNAME = 8;



  @override
  void initState() {
    super.initState();
    _stateController.resetController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Utils.initializeScreenScaling(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: CommonWidgetUtils.convertWidth(40),
            right: CommonWidgetUtils.convertWidth(40)),
        child: _setupViewPage(),
      ),
    );
  }

  Widget _setupViewPage() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: getDataFields(),
    );
  }

  List<Widget> getDataFields(){
    List<Widget> list = [];

    list.add(CommonWidgetUtils.getVerticalSpace((6*MediaQuery.of(context).size.height)/100));
    list.add(CommonWidgetUtils.getImageView(AssetsImages.app_logo, CommonWidgetUtils.convertWidth(50),
        CommonWidgetUtils.convertHeight(62)));

    list.add(CommonWidgetUtils.getVerticalSpace(40));

    list.add(CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.no_account_2)!,
        30, FontWeight.w500, AppColors.colorBlack));
    list.add(CommonWidgetUtils.getVerticalSpace(45));

    list.add(getTextField(getTranslated(context, LocalString.first_name)!, _fNameEditingController, INPUT_TYPE_FNAME));
    list.add(GetBuilder<RegisterController>(
        init: _stateController,
        builder: (controller) {
          return _getErrorLabel(controller.fNameErrorMsg);
        }));
    list.add(CommonWidgetUtils.getVerticalSpace(15));

    list.add(getTextField(getTranslated(context, LocalString.last_name)!, _lNameEditingController, INPUT_TYPE_LNAME));
    list.add(GetBuilder<RegisterController>(
        init: _stateController,
        builder: (controller) {
          return _getErrorLabel(controller.lNameErrorMsg);
        }));
    list.add(CommonWidgetUtils.getVerticalSpace(15));

    list.add(getTextField(getTranslated(context, LocalString.email)!, _emailEditingController, INPUT_TYPE_EMAIL));
    list.add(GetBuilder<RegisterController>(
        init: _stateController,
        builder: (controller) {
          return _getErrorLabel(controller.emailErrorMsg);
        }));
    list.add(CommonWidgetUtils.getVerticalSpace(15));

    list.add(getTextField(getTranslated(context, LocalString.phone)!, _phoneEditingController, INPUT_TYPE_PHONE));
    list.add(GetBuilder<RegisterController>(
        init: _stateController,
        builder: (controller) {
          return _getErrorLabel(controller.phoneErrorMsg);
        }));
    list.add(CommonWidgetUtils.getVerticalSpace(15));

    list.add(getTextField(getTranslated(context, LocalString.password)!, _pwdEditingController, INPUT_TYPE_PWD));
    list.add(GetBuilder<RegisterController>(
        init: _stateController,
        builder: (controller) {
          return _getErrorLabel(controller.pwdError);
        }));
    list.add(CommonWidgetUtils.getVerticalSpace(15));

    list.add(getTextField(getTranslated(context, LocalString.confirm_pwd)!, _confirmpwdEditingController, INPUT_TYPE_CONFIRM_PWD));
    list.add(GetBuilder<RegisterController>(
        init: _stateController,
        builder: (controller) {
          return _getErrorLabel(controller.confirmPwdError);
        }));

    list.add(CommonWidgetUtils.getVerticalSpace(40));
    list.add(_getSignUpActionView());

    list.add(CommonWidgetUtils.getVerticalSpace(50));

    list.add(_getSignInView());
    list.add(CommonWidgetUtils.getVerticalSpace(40));
    return list;
  }

  Widget _getErrorLabel(String errorMsg) {
    if(!Utils.isEmpty(errorMsg)){
      return Padding(
        padding: EdgeInsets.only(top: CommonWidgetUtils.convertHeight(5),),
        child: CommonWidgetUtils.getLabel2(errorMsg,
            12, FontWeight.w600, Colors.red),
      );
    }
    return Container();
  }


  Widget getTextField(String hint, TextEditingController editingController ,int inputType) {
    TextInputType textInputType = TextInputType.text;
    bool isPwd = false;
    int? maxLines = 1;
    int? maxLength = null;
    IconData? icon = null;
    bool isEnabled = true;
    TextCapitalization textCapitalization = TextCapitalization.none;
    if(inputType == INPUT_TYPE_NAME){
      textInputType = TextInputType.text;
      icon = Icons.business_center_outlined;
      textCapitalization = TextCapitalization.words;
    } else if(inputType == INPUT_TYPE_EMAIL){
      textInputType = TextInputType.emailAddress;
      icon = Icons.email_outlined;
    } else if(inputType == INPUT_TYPE_PHONE){
      textInputType = TextInputType.phone;
      icon = Icons.phone_iphone_outlined;
      maxLength = 10;
    } else if(inputType == INPUT_TYPE_PWD || inputType == INPUT_TYPE_CONFIRM_PWD){
      isPwd = true;
      icon = Icons.lock_outline_sharp;
    }else if(inputType == INPUT_TYPE_FNAME || inputType == INPUT_TYPE_LNAME){
      textInputType = TextInputType.text;
      icon = Icons.person_outline;
      textCapitalization = TextCapitalization.words;
    }

    return TextField(
        enabled: isEnabled,
        controller: editingController,
        textCapitalization: textCapitalization,
        keyboardType: textInputType,
        obscureText: isPwd,
        maxLines: maxLines,
        maxLength:maxLength ,
        style: TextStyle(
            fontSize: ScreenScale.convertFontSize(12,
                allowFontScaling: true),
            color: AppColors.colorBlack
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top:CommonWidgetUtils.convertWidth(18)),
          prefixIcon: Icon(icon, size: CommonWidgetUtils.convertWidth(20), color: Color(0xFF8A8A8A),),
          hintText: hint,
          hintStyle: TextStyle(
              fontSize: ScreenScale.convertFontSize(12,
                  allowFontScaling: true),
              color: Color(0xFF8A8A8A)
          ),
        )
    );
  }


  Widget _getSignUpActionView(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.register)!,
            25, FontWeight.w500, AppColors.colorBlack),
        Expanded(child: Container()),
        _getSignUpBtn(),

      ],
    );
  }

  Widget _getSignUpBtn(){
    return GestureDetector(
        onTap: (){
          _submitAction();
        },
        child: Container(
          width: CommonWidgetUtils.convertWidth(60),
          height: CommonWidgetUtils.convertWidth(60),
          decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              shape: BoxShape.circle
          ),
          child: Center(child: Icon(Icons.arrow_forward, size: CommonWidgetUtils.convertWidth(25), color: Colors.white),),
        ));
  }

  void _submitAction() {


    String fName = _fNameEditingController.text.trim(),
        lName = _lNameEditingController.text.trim(),
        email = _emailEditingController.text.trim(),
        pwd = _pwdEditingController.text.trim(),
        confirmPwd = _confirmpwdEditingController.text.trim(),
        phone = _phoneEditingController.text.trim();

    _stateController.registerAction(context,
        fName,
        lName,
        email,
        phone,
        pwd,
        confirmPwd).then((value) {
      if(value == ControllerUtils.SUCCESS){
        Utils.showToast(context, _stateController.successMsg);
        _showHomeScreen();
      }
    });
  }


  void _showHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Widget _getSignInView(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.have_account)!,
            12, FontWeight.w400, AppColors.colorBlack),
        SizedBox(width: CommonWidgetUtils.convertWidth(3),),
        GestureDetector(onTap: (){
          showLoginScreen();
        },
          child: CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.sign_in)!,
              12, FontWeight.w600, AppColors.colorPrimary),),
        Expanded(child: Container())
      ],
    );
  }
  showLoginScreen() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

}
