import 'package:al_madar/User.dart';
import 'package:al_madar/bloc/auth_bloc.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/main.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/registration/password_screen.dart';
import 'package:al_madar/registration/signupScreen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:al_madar/UserFeedBack.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhoneScreen extends StatefulWidget {
  @override
  PhoneScreenState createState() {
    return new PhoneScreenState();
  }
}

class PhoneScreenState extends State<PhoneScreen> with UserFeedback {
  AuthBloc authBloc;
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String isoCode = "+966";
  String countryCode = "SA";
  @override
  void initState() {
    authBloc = AuthBloc();
    super.initState();
  }

  setIsoCode(CountryCode code) {
    isoCode = code.dialCode;
    countryCode = code.code;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              print("taaaped");
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: new Container(
              padding: EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.05), BlendMode.dstATop),
                  image: AssetImage('assets/images/istanbul.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(100.0),
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                MadarLocalizations.of(context).trans('phone'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 10.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.redAccent,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          padding:
                              const EdgeInsets.only(left: 0.0, right: 10.0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Expanded(child: phoneTextField()),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 24.0,
                    ),
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 20.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPressed: () {
                                handleEmpty();
                              },
                              child: new Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
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
                                            fontWeight: FontWeight.bold),
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
          ),
          StreamBuilder(
            stream: authBloc.shouldShowLoader,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.hasData) {
                if (snapshot.data) {
                  return _loading();
                }
              }
              return Container();
            },
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
                  Icons.close,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loading() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(255, 255, 255, 0.4),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget phoneTextField() {
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      // onChanged: bloc.changeLoginPhone,
      style: TextStyle(
          fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
      decoration: InputDecoration(
        border: InputBorder.none,
        errorStyle: TextStyle(height: 0.1, fontSize: 12),
        icon: isoCodePicker(),
        hintText: MadarLocalizations.of(context).trans('phone_number'),
        hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 40.0),
      ),
    );
  }

  Widget isoCodePicker() {
    return CountryCodePicker(
      favorite: ['SA', 'TR', 'KW', 'AE'],
      initialSelection: 'SA',
      onChanged: (code) {
        setIsoCode(code);
      },
    );
  }

  handleEmpty() {
    if (phoneController.text.isEmpty) {
      showSnackBar('Mobile can\'t be empty');
      return;
    }
    print(phoneController.text);
    var phone = phoneController.text;
    if (phone[0] == '0' || phone[0] == '+') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSnackBar('Wrong phone format');
      });
      return;
    }
    isoCode = replaceCharAt(isoCode, 0, "00");
    print(isoCode);
    var number = isoCode + phoneController.text;
    if (phoneController.text.isNotEmpty) {
      authBloc.startLoad();
      Network.submitPhoneNumber(
        number,
      ).then((code) {
        print('code = ' + code.toString());
        authBloc.stopLoad();
        if (code == 0)
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => PasswordScreen(
                    phone: isoCode +  phoneController.text,
                  )));
        else
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SignUpScreen(
                  phone: phoneController.text, isoCode: countryCode)));
      }).catchError((e) {
        showSnackBar(e['Error']['Message']);
        authBloc.stopLoad();
      });
    }
  }

  showSnackBar(String error) {
    final err = error.split("!");
    // final snackBar = SnackBar(
    //   key: _scaffoldKey,
    //   content: Text(err.first),
    //   action: SnackBarAction(
    //     label: 'cancel',
    //     onPressed: () {
    //       _scaffoldKey.currentState.hideCurrentSnackBar();
    //     },
    //   ),
    // );
    // // _scaffoldKey.currentState.showSnackBar(snackBar);
    Fluttertoast.showToast(
        msg: err.first,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }
}
