
import 'package:flutter/cupertino.dart';

class KeyboardUtils {
  static void closeKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

}