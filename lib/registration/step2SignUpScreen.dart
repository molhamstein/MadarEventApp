import 'package:al_madar/country_list.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/main.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/auth_provider.dart';
import 'package:al_madar/network/session.dart';
import 'package:flutter/material.dart';

class Step2SignUpScreen extends StatefulWidget {
  final bool showPhoneTextFiled;

  const Step2SignUpScreen({Key key, this.showPhoneTextFiled}) : super(key: key);

  @override
  Step2SignUpScreenState createState() {
    return new Step2SignUpScreenState();
  }
}

class Step2SignUpScreenState extends State<Step2SignUpScreen> {
  List<Country> countries;
  Country selectedCountry;
  TextEditingController twitterHandlerController = TextEditingController();
  TextEditingController snapchatHandlerController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    getCountries();
    countries = [Country(-1, '-', '-')];
    selectedCountry = countries.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.dstATop),
              image: AssetImage('assets/images/istanbul.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(100.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          MadarLocalizations.of(context)
                              .trans('complete_account_text'),
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              phoneTextField(),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: new Text(
                        MadarLocalizations.of(context).trans('twitter'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        controller: twitterHandlerController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '@twitter',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24.0,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: new Text(
                        MadarLocalizations.of(context).trans('snapchat'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        controller: snapchatHandlerController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '@snapchat',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24.0,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: new Text(
                        MadarLocalizations.of(context).trans('country'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Country>(
                          items: countries.map((country) {
                            return DropdownMenuItem<Country>(
                              value: country,
                              child: Text(country.countryName),
                            );
                          }).toList(),
                          onChanged: (country) {
                            print("country selected = ${country.id}");
                            setState(() {
                              selectedCountry = country;
                            });
                          },
                          value: selectedCountry,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24.0,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: new Text(
                        MadarLocalizations.of(context).trans('city'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        controller: cityController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: MadarLocalizations.of(context).trans('your_city'),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24.0,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: new Text(
                        MadarLocalizations.of(context).trans('job'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        controller: jobController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: MadarLocalizations.of(context).trans('your_job'),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24.0,
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          updateUser();
                        },
                        child: new Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  MadarLocalizations.of(context)
                                      .trans('submit'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCountries() {
    AuthProvider.getCountries().then((countryList) {
      setState(() {
        countries = countryList.countries;
        selectedCountry = countries.first;
        print("seeeeeex selectedCountry ${selectedCountry}");
      });
    });
  }

  updateUser() {
    Session.getUser().then((user) {
      user.twitterHandle = twitterHandlerController.text;
      user.snapchatHandle = snapchatHandlerController.text;
      user.countryId = selectedCountry.id;
      user.city = cityController.text;
      user.profession = jobController.text;
      if (widget.showPhoneTextFiled) user.phone = phoneController.text;

      Session.setCountryName(selectedCountry.countryName);

      if (user.facebookId != null && user.facebookId != '') {
        Network.signUpAfterFacebookOrGoogle(user).then((user) {
          loggedIn = true;
          Navigator.of(context).pop(); //
        });
      } else if (user.googleId != null && user.googleId != '') {
        Network.signUpAfterFacebookOrGoogle(user).then((user) {
          loggedIn = true;
          Navigator.of(context).pop(); //
        });
      } else {
        Network.updateUser(user).then((user) {
          Session.setUser(user).then((s) {
            loggedIn = true;
            Navigator.of(context).pop(); //
          });
        });
      }
    });
  }

  Widget phoneTextField() {
    if (widget.showPhoneTextFiled) {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: new Text(
                    MadarLocalizations.of(context).trans('phone'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      hintText: '123456789',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
