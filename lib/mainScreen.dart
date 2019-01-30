import 'package:al_madar/AboutScreen.dart';
import 'package:al_madar/decorated_container.dart';
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
              appBar: AppBar(
                backgroundColor: Colors.orange[700],
                title: Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                  width: 40,
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => FormPage()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.airplanemode_active, color: Colors.blue,),
                          Text(MadarLocalizations.of(context).trans('trip'), style: TextStyle(color: Colors.blue),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/profileScreen');
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

  sendMail() {
    launch(
        'mailto:<services@almadarholidays.com>,<reservation@almadarholidays.com>?subject=Hello');
  }
}
