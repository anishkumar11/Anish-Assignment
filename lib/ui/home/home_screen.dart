import 'package:assignment/configs/app_colors.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {




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
        body: SafeArea(child: setUpPageView(),)
    );

  }


  Widget setUpPageView(){
    return Container(
      child: Center(child: CommonWidgetUtils.getLabel2("Welcome to my world", 16, FontWeight.w500, AppColors.colorBlack)),
    );

  }

}
