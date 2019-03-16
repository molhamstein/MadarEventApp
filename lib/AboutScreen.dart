import 'package:al_madar/madarLocalizer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  openWhats(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=$phone";

    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              Center(
                  child: GestureDetector(
                onTap: () {
                  openWhats("+905306534431");
                },
                child: Text(
                  '+90 (530) 653 44 31',
                  textDirection: TextDirection.ltr,
                ),
              )),
              Center(
                  child: GestureDetector(
                onTap: () {
                  openWhats("+905306514431");
                }, //,
                child: Text('+90 (530) 651 44 31',
                    textDirection: TextDirection.ltr),
              )),
              Center(child: Text('services@almadarholidays.com')),
              Center(child: Text('reservation@almadarholidays.com')),
            ],
          ),
        ),
      ),
    );
  }
}
