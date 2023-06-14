import 'package:assignment/configs/app_colors.dart';
import 'package:assignment/configs/local_string.dart';
import 'package:assignment/core/constants.dart';
import 'package:assignment/core/controller/controller_utils.dart';
import 'package:assignment/core/controller/message/message_controller.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/localization/language_constants.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {


  TextEditingController _commentsEditingController = TextEditingController();

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
        appBar: AppBar(
          backgroundColor: AppColors.appBarBgColor,
          title: CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.send_message)!,
              16, FontWeight.w700, AppColors.colorBlack),
        ),
        body: SafeArea(child: setUpPageView(),)
    );

  }


  Widget setUpPageView(){
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: getDataFields(),
      ),
    );
  }

  List<Widget> getDataFields(){

    List<Widget> list = [];

    list.add(Padding(padding: EdgeInsets.only(

        left: CommonWidgetUtils.convertWidth(15),
        right: CommonWidgetUtils.convertWidth(15),
        top: CommonWidgetUtils.convertHeight(30)),
      child: CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.message)!,
          14, FontWeight.w500, AppColors.colorBlack),)
    );
    list.add(Padding(padding: EdgeInsets.only(left: CommonWidgetUtils.convertWidth(15),
        right: CommonWidgetUtils.convertWidth(15),
        top: CommonWidgetUtils.convertHeight(5)),
      child: getTextField(getTranslated(context, LocalString.message_hint)!, _commentsEditingController),)
    );

    list.add(Padding(padding: EdgeInsets.symmetric(vertical: CommonWidgetUtils.convertHeight(15),
        horizontal: CommonWidgetUtils.convertWidth(15)),
      child: _getSendBtn(),)
    );

    return list;
  }

  Widget getTextField(String hint, TextEditingController editingController) {

    TextInputType textInputType = TextInputType.multiline;
    TextCapitalization textCapitalization = TextCapitalization.sentences;
    int? maxLine = null;

    return TextField(
      controller: editingController,
      keyboardType: textInputType,
      maxLines: maxLine,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: CommonWidgetUtils.convertWidth(10),
          right: CommonWidgetUtils.convertWidth(10),),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey,),
        filled: true,
        fillColor: Colors.white70,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(CommonWidgetUtils.convertWidth(5))),
          borderSide: BorderSide(color: AppColors.colorGrey9, width: CommonWidgetUtils.convertWidth(1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(CommonWidgetUtils.convertWidth(5))),
          borderSide: BorderSide(color: AppColors.darkRedColor, width: CommonWidgetUtils.convertWidth(1)),
        ),
      ),
    );

  }

  Widget _getSendBtn(){
    return ElevatedButton(
      onPressed: (){
        _submitAction();
      },
      child: CommonWidgetUtils.getLabel2(getTranslated(context, LocalString.send)!, 13,
          FontWeight.w600, Colors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueColor,
      ),);
  }

  void _submitAction() {
    String comments = _commentsEditingController.text.trim();
    MessageController _stateController = Get.find<MessageController>();
    _stateController.resetController();
    _stateController.sendMessage(context, comments).then((value) {
      if(value == ControllerUtils.SUCCESS){
        Utils.showToast(context, _stateController.successMsg);
        _commentsEditingController.clear();
      }else if(value == ControllerUtils.ERROR){
        Utils.showToast(context, _stateController.errorMsg);
      }
    });
  }

}
