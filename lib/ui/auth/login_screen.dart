import 'package:assignment/configs/app_colors.dart';
import 'package:assignment/configs/assets_images.dart';
import 'package:assignment/configs/local_string.dart';
import 'package:assignment/core/controller/auth/login_controller.dart';
import 'package:assignment/core/controller/controller_utils.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/localization/language_constants.dart';
import 'package:assignment/ui/auth/forgot_pwd_screen.dart';
import 'package:assignment/ui/auth/registration_screen.dart';
import 'package:assignment/ui/home/home_screen.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/flutter_screen_scaling.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen(){
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginController _stateController = Get.find<LoginController>();
  final TextEditingController _emailEditingController = TextEditingController(),
      _pwdEditingController = TextEditingController();

  String emailError = "",
      pwdError = "";

  int INPUT_TYPE_EMAIL = 1, INPUT_TYPE_PWD = 2;



  @override
  void initState() {
    super.initState();
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

    list.add(CommonWidgetUtils.getVerticalSpace(50));

    list.add(CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.log_in).toString(),
        30, FontWeight.w500, AppColors.colorBlack));
    list.add(CommonWidgetUtils.getVerticalSpace(40));

    list.add(getTextField(getTranslated(context, LocalString.email)!, _emailEditingController, INPUT_TYPE_EMAIL));
    list.add(GetBuilder<LoginController>(
        init: _stateController,
        builder: (controller) {
          String error = "";
          switch(controller.processStatus){
            case ControllerUtils.ERROR:
              error = controller.emailError;
              break;
          }
          return getErrorLabel(error);
        }));
    list.add(CommonWidgetUtils.getVerticalSpace(30));

    list.add(getTextField(getTranslated(context, LocalString.password)!, _pwdEditingController, INPUT_TYPE_PWD));
    list.add(GetBuilder<LoginController>(
        init: _stateController,
        builder: (controller) {
          String error = "";
          switch(controller.processStatus){
            case ControllerUtils.ERROR:
              error = controller.pwdError;
              break;
          }
          return getErrorLabel(error);
        }));

    list.add(CommonWidgetUtils.getVerticalSpace(40));
    list.add(_getSiginActionView());

    list.add(CommonWidgetUtils.getVerticalSpace(50));
    list.add(_getForgotPwdButton());
    list.add(CommonWidgetUtils.getVerticalSpace(10));
    list.add(_getSignupView());
    list.add(CommonWidgetUtils.getVerticalSpace(40));
    return list;
  }

  Widget getErrorLabel(String errorMsg) {
    if(!Utils.isEmpty(errorMsg)){
      return Padding(
        padding: EdgeInsets.only(top: CommonWidgetUtils.convertHeight(5),
        left: CommonWidgetUtils.convertWidth(10),),
        child: CommonWidgetUtils.getLabel2(errorMsg,
            12, FontWeight.w600, Colors.red),
      );
    }
    return Container();
  }

  Widget getTextField(String hint, TextEditingController editingController ,int inputType) {
    TextInputType textInputType = TextInputType.text;
    bool isPwd = false;
    IconData icon = Icons.email_outlined;
    if(inputType == INPUT_TYPE_EMAIL){
      textInputType = TextInputType.emailAddress;
    }

    if(inputType == INPUT_TYPE_PWD){
      isPwd = true;
      icon = Icons.lock_outline_sharp;
    }

    return TextField(
        controller: editingController,
        keyboardType: textInputType,
        obscureText: isPwd,
        maxLines: 1,
        onChanged: (String value) async {
          if(inputType == INPUT_TYPE_EMAIL){
            _stateController.validateEmail(context, value);
          }else if(inputType == INPUT_TYPE_PWD){
            _stateController.validatePassword(context, value);
          }
        },
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

  Widget _getSiginActionView(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.sign_in).toString(),
            25, FontWeight.w500, AppColors.colorBlack),
        Expanded(child: Container()),
        _getSignInBtn(),

      ],
    );
  }

  Widget _getSignInBtn(){
    return GestureDetector(onTap: (){
      _submitAction();
    },child: Container(
      width: CommonWidgetUtils.convertWidth(60),
      height: CommonWidgetUtils.convertWidth(60),
      decoration: BoxDecoration(
          color: AppColors.colorPrimary,
          shape: BoxShape.circle
      ),
      child: Center(child: Icon(Icons.arrow_forward, size: CommonWidgetUtils.convertWidth(25), color: Colors.white),),
    ),);
  }

  void _submitAction() {
    String email = _emailEditingController.text.trim();
    String pwd = _pwdEditingController.text.trim();
    _stateController.loginAction(context, email, pwd).then((value) {
      if(value == ControllerUtils.SUCCESS){
        _showHomeScreen();
      }
    });
  }

  void _showHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Widget _getSignupView(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.no_account_1).toString(),
            12, FontWeight.w400, AppColors.colorBlack),
        SizedBox(width: CommonWidgetUtils.convertWidth(3),),
        GestureDetector(onTap: (){

          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => RegistrationScreen()));
        },
          child: CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.no_account_2).toString(),
              12, FontWeight.w600, AppColors.colorPrimary),),
        Expanded(child: Container())
      ],
    );
  }

  Widget _getForgotPwdButton(){
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
      },
      child: CommonWidgetUtils.getCenterTextLabel(getTranslated(context, LocalString.forgot_pwd).toString(),
          12, FontWeight.w600, AppColors.colorBlack2),
    );
  }

}
