import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  @override
  FormPageState createState() {
    return new FormPageState();
  }
}

class FormPageState extends State<FormPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numOfAdultsController = TextEditingController();
  TextEditingController numOfChildrenController = TextEditingController();
  TextEditingController numOfRoomsController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  int _radioValue;
  bool _checkBox1;
  bool _checkBox2;
  bool _checkBox3;
  DateTime _arrivalTime;
  DateTime _leavingTime;
  bool _isLoading;

  @override
  void initState() {
    _checkBox1 = false;
    _checkBox2 = false;
    _checkBox3 = false;
    _arrivalTime = DateTime.now();
    _leavingTime = DateTime.now();
    _isLoading = false;
    loadFromCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
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
          child: Stack(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              MadarLocalizations.of(context)
                                  .trans('form_statement'),
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              MadarLocalizations.of(context)
                                  .trans('form_sub_statement'),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  cityField(),
                  fullNameField(),
                  phoneNumberField(),
                  arrivingDateField(),
                  leavingDateField(),
                  numberOfAdultsField(),
                  numberOfChildrenField(),
                  numberOfRoomsField(),
                  checkboxes(),
                  radioButtons(),
                  detailsField(),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 50.0),
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
                              handleEmptyAndSubmit();
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
              _loading(),
            ],
          ),
        ),
      ),
    );
  }

  Widget fullNameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        MadarLocalizations.of(context).trans('user_name'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText:
                          MadarLocalizations.of(context).trans('user_name'),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cityField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        MadarLocalizations.of(context).trans('city'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: MadarLocalizations.of(context).trans('city'),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget phoneNumberField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        MadarLocalizations.of(context).trans('phone'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '0123456789',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget numberOfAdultsField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        MadarLocalizations.of(context)
                            .trans('number_of_adults'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    controller: numOfAdultsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '5',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget numberOfChildrenField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: new Text(
                    MadarLocalizations.of(context).trans('number_of_children'),
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
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    controller: numOfChildrenController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '5',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget numberOfRoomsField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        MadarLocalizations.of(context).trans('number_of_rooms'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    controller: numOfRoomsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '5',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget arrivingDateField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        MadarLocalizations.of(context).trans('arrival_date'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: InkWell(
              onTap: () {
                _selectDate().then((date) {
                  if (date != null)
                    setState(() {
                      _arrivalTime = date;
                    });
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.date_range),
                    SizedBox(
                      width: 20,
                    ),
                    Text(formattedDate(_arrivalTime)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leavingDateField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        MadarLocalizations.of(context).trans('leaving_date'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: InkWell(
              onTap: () {
                _selectDate().then((date) {
                  if (date != null)
                    setState(() {
                      _leavingTime = date;
                    });
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.date_range),
                    SizedBox(
                      width: 20,
                    ),
                    Text(formattedDate(_leavingTime)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget checkboxes() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                MadarLocalizations.of(context).trans('tours'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                '*',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: _checkBox1,
                onChanged: (val) {
                  setState(() {
                    _checkBox1 = val;
                  });
                },
              ),
              Text(
                MadarLocalizations.of(context).trans('pick_up_from_airport'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: _checkBox2,
                onChanged: (val) {
                  setState(() {
                    _checkBox2 = val;
                  });
                },
              ),
              Text(
                MadarLocalizations.of(context).trans('pick_up_to_airport'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: _checkBox3,
                onChanged: (val) {
                  setState(() {
                    _checkBox3 = val;
                  });
                },
              ),
              Text(
                MadarLocalizations.of(context).trans('daily_tours'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget radioButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0, right: 40.0, left: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                MadarLocalizations.of(context).trans('accommodation_type'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                '*',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: 4,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                  });
                },
                groupValue: _radioValue,
              ),
              Text(
                MadarLocalizations.of(context).trans('4_stars_hotel'),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: 5,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                  });
                },
                groupValue: _radioValue,
              ),
              Text(
                MadarLocalizations.of(context).trans('5_stars_hotel'),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: 1,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                  });
                },
                groupValue: _radioValue,
              ),
              Text(
                MadarLocalizations.of(context).trans('hotel_suite'),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget detailsField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        MadarLocalizations.of(context)
                            .trans('trip_description'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    controller: detailsController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: MadarLocalizations.of(context)
                          .trans('ex_family_trip'),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  loadFromCache() {
    Session.getUser().then((user) {
      setState(() {
        nameController.text = user.displayName;
        phoneController.text = user.phone;
      });
    });
  }

  Future<DateTime> _selectDate() async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2022),
    );
  }

  String formattedDate(date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  submit() {
    setState(() {
      _isLoading = true;
    });
    Session.getAccessToken().then((token) {
      Network.submitForm(
              token,
              nameController.text,
              phoneController.text,
              cityController.text,
              formattedDate(_arrivalTime),
              formattedDate(_leavingTime),
              numOfAdultsController.text,
              numOfChildrenController.text,
              numOfRoomsController.text,
              _checkBox1,
              _checkBox2,
              _checkBox3,
              _radioValue,
              detailsController.text)
          .then((nil) {
        setState(() {
          _isLoading = false;
          Future.delayed(Duration(seconds: 2)).then((_){
            Navigator.of(context).pop(true);
          });
          showSnackBar(MadarLocalizations.of(context).trans('form_submitted'));
        });

      });
    });
  }

  Widget _loading() {
    if (_isLoading)
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(255, 255, 255, 0.4),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    else
      return Container();
  }

  showSnackBar(String error) {
    final err = error.split("!");
    final snackBar = SnackBar(
      content: Text(err.first),
      action: SnackBarAction(
        label: 'cancel',
        onPressed: () {
          _scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),
    );
//    Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  handleEmptyAndSubmit() {
    if (phoneController.text.isEmpty) {
      showSnackBar('Phone can\'t be empty');
      return;
    }
    if (nameController.text.isEmpty) {
      showSnackBar('Name cant be empty');
      return;
    }
    if (numOfAdultsController.text.isEmpty) {
      showSnackBar('Number of Adults cant be empty');
      return;
    }
    if (numOfRoomsController.text.isEmpty) {
      showSnackBar('Number of Rooms cant be empty');
      return;
    }
    if (detailsController.text.isEmpty) {
      showSnackBar('Details cant be empty');
      return;
    }
    if (cityController.text.isEmpty) {
      showSnackBar('City cant be empty');
      return;
    }

    submit();
  }
}
