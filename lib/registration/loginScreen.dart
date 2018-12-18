import 'package:al_madar/User.dart';
import 'package:al_madar/bloc/auth_bloc.dart';
import 'package:al_madar/icons/social_icons_icons.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/registration/step2SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';


class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _shouldLoad = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screen();
  }

  screen() {
    return Material(
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            new Container(
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
                    padding: EdgeInsets.all(110.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding:
                          const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: new Text(
                            MadarLocalizations.of(context).trans('user_name'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextField(
                            controller: userNameController,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: MadarLocalizations.of(context)
                                  .trans('user_name'),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme
                                          .of(context)
                                          .accentColor)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme
                                          .of(context)
                                          .accentColor)),
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
                          padding:
                          const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: new Text(
                            MadarLocalizations.of(context).trans('password'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme
                                          .of(context)
                                          .accentColor)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme
                                          .of(context)
                                          .accentColor)),
                              border: InputBorder.none,
                              hintText: '*********',
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: new FlatButton(
                          child: new Text(
                            MadarLocalizations.of(context)
                                .trans('forgot_password'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          onPressed: () {
                            sendMail();
                          },
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                            color: Theme
                                .of(context)
                                .primaryColor,
                            onPressed: () {
                              authBloc.login('00963933074900', 'Asdf@1234');
//                              authBloc.login(userNameController.text, passwordController.text);
                              authBloc.startLoad();
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
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.all(8.0),
                            decoration:
                            BoxDecoration(border: Border.all(width: 0.25)),
                          ),
                        ),
                        Text(
                          MadarLocalizations.of(context)
                              .trans('or_connect_with'),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.all(8.0),
                            decoration:
                            BoxDecoration(border: Border.all(width: 0.25)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.only(right: 8.0),
                            alignment: Alignment.center,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new FlatButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(30.0),
                                    ),
                                    color: Color(0Xff3B5998),
                                    onPressed: () => {},
                                    child: new Container(
                                      child: new Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: new FlatButton(
                                              onPressed: loginWithFacebook,
                                              padding: EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                              ),
                                              child: new Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: <Widget>[
                                                  Icon(
                                                    SocialIcons.facebook,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "FACEBOOK",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
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
                        ),
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.only(left: 8.0),
                            alignment: Alignment.center,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new FlatButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(30.0),
                                    ),
                                    color: Color(0Xffdb3236),
                                    onPressed: () => {},
                                    child: new Container(
                                      child: new Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: new FlatButton(
                                              onPressed: loginWithGoogle,
                                              padding: EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                              ),
                                              child: new Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: <Widget>[
                                                  Icon(
                                                    SocialIcons.google,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "GOOGLE",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: authBloc.getUser,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                print(snapshot.connectionState);
                if (snapshot.hasData) {
                  authBloc.stopLoad();
                  Session.setUser(snapshot.data);
                  Future.delayed(Duration(microseconds: 1)).then((s) =>
                      Navigator.pushReplacementNamed(
                          context, '/mainScreen')); //TODO: find another way
                }
                return Container();
              },
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
            )
          ],
        ),
      ),
    );
  }

  Future loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        Network.getFacebookProfile(result.accessToken.token).then((profile) {
          authBloc.startLoad();
          Network.signUpWithFacebook(
              profile['name'], profile['email'], profile['id'])
              .then((json) {
            if (json['ResultCode'] == -3) {
              Session.setUserFromFacebook(
                  profile['name'], profile['email'], profile['id'])
                  .then((non) {
                    authBloc.stopLoad();
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new Step2SignUpScreen(
                          showPhoneTextFiled: true,
                        )));
              });
            } else {
              print(json['LoggedInUser']);
              Session.setUser(User.fromJson(json['LoggedInUser'])).then((non) {
                Navigator.pushReplacementNamed(context, '/mainScreen');
              });
            }
          });
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print(result.status);
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  loginWithGoogle() {
    var googleLogin = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    googleLogin.signIn().then((account) {
      print(account.displayName);

      Network.signUpWithGoogle(account.displayName, account.email, account.id)
          .then((json) {
        if (json['ResultCode'] == -4) {
          authBloc.startLoad();
          Session.setUserFromGoogle(
              account.displayName, account.email, account.id)
              .then((non) {
            authBloc.stopLoad();
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                builder: (context) =>
                new Step2SignUpScreen(
                  showPhoneTextFiled: true,
                ),
              ),
            );
          });
        } else {
          Session.setUser(User.fromJson(json['LoggedInUser'])).then((non) {
            Navigator.pushReplacementNamed(context, '/mainScreen');
          });
        }
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  Widget _loading() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Color.fromRGBO(255, 255, 255, 0.4),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  sendMail() {
    launch(
        'mailto:<services@almadarholidays.com>?subject=I Forgot my Password&body=Could you please reset my password.');
  }
}
