import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/registration/chooseAccountScreen.dart';
import 'package:al_madar/registration/loginScreen.dart';
import 'package:al_madar/registration/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => new _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            LoginScreen(),
            ChooseAccountScreen(
              onLoginPressed: gotoLogin,
              onSignUpPressed: gotoSignup,
            ),
            SignUpScreen(),
          ],
          scrollDirection: Axis.horizontal,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment:
                MadarLocalizations.of(context).locale.languageCode == 'en'
                    ? Alignment.topLeft
                    : Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    ));
  }
}
