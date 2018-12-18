import 'package:al_madar/madarLocalizer.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 88.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    MadarLocalizations.of(context).trans('long_text'),
                  ),
                ),
              ),
              Center(child: Text('+90 (530) 653 44 31')),
              Center(child: Text('+90 (530) 651 44 31')),
              Center(child: Text('services@almadarholidays.com')),
              Center(child: Text('reservation@almadarholidays.com')),
            ],
          ),
        ),
      ),
    );
  }
}