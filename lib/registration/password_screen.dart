import 'package:al_madar/bloc/auth_bloc.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/main.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class PasswordScreen extends StatefulWidget {
  final String phone;

  const PasswordScreen({Key key, this.phone}) : super(key: key);

  @override
  PasswordScreenState createState() {
    return new PasswordScreenState();
  }
}

class PasswordScreenState extends State<PasswordScreen> {
  AuthBloc authBloc;
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // key: _scaffoldKey,
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
                                MadarLocalizations.of(context)
                                    .trans('password'),
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
                              new Expanded(
                                child: TextField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    hintText: '*****',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, left: 20.0),
                                child: new FlatButton(
                                  child: new Text(
                                    MadarLocalizations.of(context)
                                        .trans('forgot_password'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor,
                                      fontSize: 15.0,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  onPressed: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ForgetPasswordScreen()));
                                    sendMail();
                                  },
                                ),
                              )
                            ]),
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
                              color: Colors.blue[700],
                              onPressed: handleEmpty,
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
                                            .trans('login'),
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

  sendMail() async {
    var subject = Uri.encodeFull('I Forgot my Password');
    var body = Uri.encodeFull('Could you please reset my password.');
    var url = 'mailto:services@almadarholidays.com?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

  handleEmpty() {
    if (passwordController.text.isEmpty) {
      showSnackBar('Password can\'t be empty');
      return;
    }

    if (passwordController.text.isNotEmpty) {
      authBloc.startLoad();
      Network.login(widget.phone, passwordController.text).then((user) {
        authBloc.stopLoad();
        Session.setUser(user);
        loggedIn = true;
        Navigator.of(context).pop();
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
    // _scaffoldKey.currentState.showSnackBar(snackBar);
    Fluttertoast.showToast(
        msg: err.first,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  login() {
    authBloc.startLoad();
    Network.login(widget.phone, passwordController.text).then((user) {
      authBloc.stopLoad();
      Session.setUser(user);
      loggedIn = true;
      Navigator.of(context).pop();
    }).catchError((e) {
      authBloc.stopLoad();
      showSnackBar(e['Error']['Message']);
    });
  }
}
