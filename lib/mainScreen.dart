import 'dart:io';

import 'package:al_madar/AboutScreen.dart';
import 'package:al_madar/decorated_container.dart';
import 'package:al_madar/form.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/main.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/newsScreen.dart';
import 'package:al_madar/now_screen.dart';
import 'package:al_madar/offersScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class MainScreen extends StatefulWidget {
  final bool afterLogin;
  const MainScreen({Key key, this.afterLogin = false}) : super(key: key);
  @override
  MainScreenState createState() {
    return new MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  String phone = "905306514431";

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin  =new FlutterLocalNotificationsPlugin() ;

  @override
  initState() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform =new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    _firebaseMessaging.configure(onMessage: (Map <String , dynamic> msg){
      print(msg.keys.toString());
      print(msg);


      showNotification(msg);
    });



    Session.getWhatsappPhone().then((value) {
      if (value.isNotEmpty) {
        phone = value;
      }
    });
    getPhone();
//    _firebaseMessaging.configure();
    _firebaseMessaging.getToken().then((token) {
//      print('token = ' + token);
    }).catchError((e) {
//      print(e);
    });

    _firebaseMessaging.onTokenRefresh.listen((token) {
//      print('token =  $token');
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.subscribeToTopic('allUsers');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = [
      loggedIn ? 'logout' : 'login',
    ];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[700],
          title: Image.asset(
            'assets/images/logo.png',
            height: 40,
            width: 40,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: InkWell(
                onTap: () {
                  openWhats(phone);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Icon(
                    //   Icons.person_outline,
                    //   color: Colors.white,
                    // ),
                    new Image.asset('assets/images/ic_whatsapp.png',width: 30,height: 30,)
//                    Text(MadarLocalizations.of(context).trans('contact_us'))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: InkWell(
                onTap: () {
                  if (loggedIn) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FormPage()));
                  } else
                    Navigator.of(context).pushNamed('/registrationScreen');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.airplanemode_active,
                      color: Colors.blue,
                    ),
                    Text(
                      MadarLocalizations.of(context).trans('trip'),
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: InkWell(
                onTap: () {
                  if (loggedIn)
                    Navigator.pushNamed(context, '/profileScreen');
                  else
                    Navigator.of(context).pushNamed('/registrationScreen');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    Text(MadarLocalizations.of(context).trans('me'))
                  ],
                ),
              ),
            ),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return menuItems.map((item) {
                  return PopupMenuItem(
                    child: Text(
                      MadarLocalizations.of(context).trans(item),
                    ),
                    value: item,
                  );
                }).toList();
              },
              onSelected: (title) {
                print(title);
                if (title == "logout") {
                  final session = Session();
                  session.logout();
                  loggedIn = false;
                  Navigator.pushNamed(context, '/registrationScreen');
                }
                if (title == 'contact_us') {
                  openWhats(phone);
                }
                if (title == 'login') {
                  Navigator.pushNamed(context, '/registrationScreen');
                }
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.white,
            tabs: [
              new Tab(
                text: MadarLocalizations.of(context).trans('now'),
              ),
              new Tab(
                text: MadarLocalizations.of(context).trans('news'),
              ),
              new Tab(
                text: MadarLocalizations.of(context).trans('offers'),
              ),
              new Tab(
                text: MadarLocalizations.of(context).trans('about'),
              ),
            ],
          ),
        ),
        body: DecoratedContainer(
          child: TabBarView(
            children: [
              NowScreen(),
              NewsScreen(),
              OffersScreen(),
              AboutScreen(),
            ],
          ),
        ),
      ),
    );
  }

  getPhone() async {
    Network.getWhatsappNo().then((whatsPhone) {
      if (whatsPhone.isNotEmpty) {
        Session.setWhatsappPhone(whatsPhone);
        setState(() {
          phone = whatsPhone;
        });
      }
    });
  }

  sendMail() {
    launch(
        'mailto:<services@almadarholidays.com>,<reservation@almadarholidays.com>?subject=Hello');
  }

  openWhats(String phone) async {
    phone = phone.replaceAll(new RegExp('\"'), "");
    print("nummmber ${phone.toString()}");
    var whatsappUrl = "whatsapp://send?phone=${phone.toString()}";

    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

   showNotification(Map<String, dynamic> msg) async {
    print(msg);
    var android = new AndroidNotificationDetails("channel_id", "Channel Name", "Channel description");
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
   await flutterLocalNotificationsPlugin.show(0, msg['notification']['title'], msg['notification']['body'], platform);
   }
}
