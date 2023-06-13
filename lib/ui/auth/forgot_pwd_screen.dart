import 'package:assignment/core/controller/controller_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:assignment/configs/app_colors.dart';
import 'package:assignment/configs/assets_images.dart';
import 'package:assignment/configs/local_string.dart';
import 'package:assignment/core/controller/auth/forgot_controller.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/localization/language_constants.dart';
import 'package:assignment/ui/auth/login_screen.dart';
import 'package:assignment/widgets/common_widget_utils.dart';


class ForgotPasswordScreen extends StatefulWidget {

  ForgotPasswordScreen(){
  }

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final ForgotController _stateController = Get.find<ForgotController>();

  TextEditingController _emailController = TextEditingController();


  _ForgotPasswordScreenState(){
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Utils.initializeScreenScaling(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _setUpViewPage(),
      ),);
  }

  Widget _setUpViewPage() {
    return Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top:40),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: _getDataFields(),
        ));
  }

  List<Widget> _getDataFields(){
    List<Widget> list = [];

    list.add(Padding(
      padding: EdgeInsets.all(CommonWidgetUtils.convertHeight(30)),
      child: Row(children: <Widget>[
        CommonWidgetUtils.getImageView(
            AssetsImages.app_logo, CommonWidgetUtils.convertWidth(100), CommonWidgetUtils.convertWidth(100))
      ], mainAxisAlignment: MainAxisAlignment.center),
    ));

    list.add(Padding(
        padding: EdgeInsets.only(left: CommonWidgetUtils.convertWidth(10)),
        child: Align(
            child: _getTitleTextLabel(getTranslated(context, LocalString.forgot_pwd)!),
            alignment: Alignment.topLeft)));
    list.add(Padding(
      padding: EdgeInsets.all(CommonWidgetUtils.convertWidth(10)),
      child: _getTextLabel(
          getTranslated(context, LocalString.forgot_pwd_header)!),
    ));

    list.add(Padding(
      padding: EdgeInsets.all(CommonWidgetUtils.convertWidth(10)),
      child: _getTextField( getTranslated(context, LocalString.email_address)!),
    ));

    list.add(GetBuilder<ForgotController>(
        init: _stateController,
        builder: (controller) {
          String loginError = "";
          switch(controller.processStatus){
            case ControllerUtils.FAILED:
              loginError = getTranslated(context, LocalString.network_error)!;
              break;
            case ControllerUtils.ERROR:
              loginError = controller.errorMsg;
              break;
          }
          return _getLoginErrorLabel(loginError);
        }));
    list.add(CommonWidgetUtils.getVerticalSpace(20));
    list.add(_getSubmitButton());
    list.add(_getLoginButton());

    return list;
  }

  Widget _getLoginErrorLabel(String errorMsg) {
    if(!Utils.isEmpty(errorMsg)){
      return Padding(
        padding: EdgeInsets.only(left: CommonWidgetUtils.convertWidth(10),),
        child: CommonWidgetUtils.getLabel2(errorMsg,
            12, FontWeight.w600, Colors.red),
      );
    }
    return Container();
  }

  Widget _getLoginButton() {
    return GestureDetector(
      onTap: () {
        _showLoginScreen();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              colors: [
                Colors.transparent, //start
                Colors.transparent, //center
                Colors.transparent, //end
              ],
            )),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          getTranslated(context, LocalString.back_to_login)!,
          style: TextStyle(color: AppColors.colorPostDarkText, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getTitleTextLabel(String text) {
    return CommonWidgetUtils.getLabel2(text, 20, FontWeight.w700, Colors.black);
  }

  Widget _getTextLabel(String text) {
    return Text(text,
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontStyle: FontStyle.normal));
  }

  Widget _getSubmitButton() {

    return GestureDetector(
      onTap: () {
        _submitAction();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              colors: [
                AppColors.colorPrimary,//start
                AppColors.colorPrimary,//center
                AppColors.colorPrimary,//end
              ],
            )),
        padding: const EdgeInsets.all(10.0),
        child: CommonWidgetUtils.getCenterTextLabel(getTranslated(context, LocalString.reset_pwd)!,
            15, FontWeight.w600, Colors.white),
        ),
      );
  }

  Widget _getTextField(String hint) {
    return TextField(
      controller: _emailController,
      onChanged: (String value) async {
        _stateController.validateEmail(context, value);
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            _emailController.clear();
            _stateController.validateEmail(context, "");
          } ,
          icon: Icon(Icons.clear),
        ),
        labelText: hint,
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }


  void _showLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _submitAction() {
    String email = _emailController.text.trim();
    _stateController.forgotPwdAction(context, email).then((value) {
      if(value == ControllerUtils.SUCCESS){
        //Utils.showToast(context, _stateController.successMsg);
        _showLoginScreen();
      }
    });
  }
}

