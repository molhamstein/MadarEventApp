import 'package:al_madar/User.dart';
import 'package:al_madar/country_list.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/auth_provider.dart';
import 'package:al_madar/network/session.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({Key key, this.user}) : super(key: key);

  @override
  EditProfileState createState() {
    return new EditProfileState();
  }
}

class EditProfileState extends State<EditProfile> {
  List<Country> countries;
  Country selectedCountry;
  TextEditingController displayNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController twitterHandlerController = TextEditingController();
  TextEditingController snapchatHandlerController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  void initState() {
    countries = [Country(widget.user.countryId, '-', '-')];
    selectedCountry = countries.first;
    print("selecteeeeed = ${widget.user.countryId}");
    print("selecteeeeed = ${widget.user.displayName}");
    getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
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
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: new Text(
                        MadarLocalizations.of(context).trans('email'),
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
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        controller: emailController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          hintText: 'example@example.com',
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
                        MadarLocalizations.of(context).trans('user_name'),
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
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        controller: displayNameController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          hintText:
                              MadarLocalizations.of(context).trans('user_name'),
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
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
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
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          hintText: '123456789',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                          onChanged: (Country country) {
                            setState(() {
                              selectedCountry = country;
                            });
                          },
                          value: selectedCountry.id == 0 ? countries.first : selectedCountry,
                          isDense: true,
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
                          hintText: 'Istanbul',
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
                          hintText: 'Software Engineering',
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
        print('countries = ' + countries.length.toString());
        print('selectedCountry id = ' + selectedCountry.id.toString());
        if (selectedCountry.id != null && selectedCountry.id != 0) {
          selectedCountry = countries.where((country) => country.id == selectedCountry.id).first;
        }
        displayNameController.text = widget.user.displayName;
        phoneController.text = widget.user.phone;
        emailController.text = widget.user.email;
        twitterHandlerController.text = widget.user.twitterHandle;
        snapchatHandlerController.text = widget.user.snapchatHandle;
        cityController.text = widget.user.city;
        jobController.text = widget.user.profession;
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
      user.displayName = displayNameController.text;
      user.email = emailController.text;
      user.phone = phoneController.text;
      user.countryId = selectedCountry.id;
      Network.updateUser(user).then((user) {
        Session.setUser(user).then((s) {
          Navigator.pop(context); //
        });
      });
    });
  }
}