import 'package:al_madar/bloc/base_bloc.dart';
import 'package:al_madar/bloc/mainBloc.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/mainScreen.dart';
import 'package:al_madar/profile_screen.dart';
import 'package:al_madar/registration/forgetPasswordScreen.dart';
import 'package:al_madar/registration/phone_screen.dart';
import 'package:al_madar/registration/registrationScreen.dart';
import 'package:al_madar/registration/step2SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());
bool loggedIn;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al Madar Holidays',
      home: MyHomePage(title: 'Al Madar Holidays'),
    );
  }
}

// red (ec1e42)
// blue (14224f)

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainBloc mainBloc;
  final FirebaseMessaging _messaging = FirebaseMessaging();

  final appColors = [
    const Color(0xFFEC1E42),
    const Color(0xFF14224F),
  ];

  @override
  void initState() {
    mainBloc = MainBloc();
    _messaging.getToken().then((token){print(token);});
//
//    _messaging.configure(onMessage: (Map<String, dynamic> message){
//      print('on message');
////
//    },onResume:(Map<String, dynamic> message){
//      print(' onResume');
//
//    },onLaunch:(Map<String, dynamic> message){
//      print(' onResume');
//
//    }  );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ar', ''),
      ],
      localizationsDelegates: [
        const MadarLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (locale != null) if (supportedLocale.languageCode ==
                  locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: appColors.first,
        accentColor: appColors.last,
        primaryColorDark: Colors.orange[700],

      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new LandingPage(),
        '/registrationScreen': (BuildContext context) =>
            new PhoneScreen(),
        '/forgetPasswordScreen': (BuildContext context) =>
            new ForgetPasswordScreen(),
        '/mainScreen': (BuildContext context) => new MainScreen(),
        '/step2SignUpScreen': (BuildContext context) => new Step2SignUpScreen(
              showPhoneTextFiled: false,
            ),
        '/profileScreen': (BuildContext context) => new ProfileScreen(),
      },
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() {
    return new LandingPageState();
  }
}

class LandingPageState extends State<LandingPage> {
  BaseBloc baseBloc;

  @override
  void initState() {
    baseBloc = BaseBloc();
    baseBloc.userLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: baseBloc.isUserLoggedOn,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            loggedIn = true;
            Future.delayed(Duration(microseconds: 1)).then((s) =>
                Navigator.pushReplacementNamed(
                    context, '/mainScreen')); //TODO: find another way
          } else {
            loggedIn = false;
            Future.delayed(Duration(microseconds: 1)).then((s) =>
                Navigator.pushReplacementNamed(
                    context, '/mainScreen')); //TODO: find another way
//            Future.delayed(Duration(microseconds: 1)).then((s) =>
//                Navigator.pushReplacementNamed(
//                    context, '/registrationScreen')); //TODO: find another way
          }
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
        );
      },
    );
  }

  @override
  void dispose() {
    baseBloc.dispose();
    super.dispose();
  }
}
