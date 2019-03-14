import 'package:flutter/material.dart';

mixin UserFeedback {
  static const greyColor = Color(0xFF666666);
  void showInSnackBar(String value, BuildContext context,
      {Color color = greyColor}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Scaffold.of(context)?.removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(
        // MadarLocalizations.of(context).trans(value)
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }
}
