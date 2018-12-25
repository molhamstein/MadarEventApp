import 'package:al_madar/AboutScreen.dart';
import 'package:al_madar/form.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/newsScreen.dart';
import 'package:al_madar/now_screen.dart';
import 'package:al_madar/offersScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() {
    return new MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  final List<String> menuItems = [
    'contact_us',
    'logout',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FormPage()));
          },
          child: Icon(
            Icons.map,
            color: Colors.white,
          ),
        ),
        appBar: PreferredSize(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.3), BlendMode.dstATop),
                    image: AssetImage('assets/images/istanbul.png'),
                    fit: BoxFit.cover,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment(0.8, 0.0),
                  ),
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                title: Image.asset(
                  'assets/images/logo_white.png',
                  height: 40,
                  width: 40,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profileScreen');
                    },
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
                        Navigator.pushReplacementNamed(
                            context, '/registrationScreen');
                      }
                      if (title == 'contact_us') {
                        sendMail();
                      }
                    },
                  ),
                ],
                bottom: TabBar(
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
            ],
          ),
          preferredSize: Size.fromHeight(100.0),
        ),
        body: TabBarView(
          children: [
            NowScreen(),
            NewsScreen(),
            OffersScreen(),
            AboutScreen(),
          ],
        ),
      ),
    );
  }

  sendMail() {
    launch(
        'mailto:<services@almadarholidays.com>,<reservation@almadarholidays.com>?subject=Hello');
  }
}
