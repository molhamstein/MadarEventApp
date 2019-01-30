import 'package:al_madar/User.dart';
import 'package:al_madar/edit_password.dart';
import 'package:al_madar/edit_profile.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/widgets/offer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() {
    return new ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  List<OfferWidget> offers = [];
  final List<String> menuItems = [
    'edit_profile',
    'edit_password',
  ];

  User user;

  @override
  void initState() {
    getFavoriteOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.3), BlendMode.dstATop),
                  image: AssetImage('assets/images/istanbul.jpg'),
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
              actions: <Widget>[
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
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
                    if (title == "edit_profile") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(user: user),
                        ),
                      );
                    }
                    if (title == 'edit_password') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPassword(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hey',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  nameText(),
                  countryText(),
                ],
              ),
            )
          ],
        ),
        preferredSize: Size.fromHeight(180.0),
      ),
      body: body(),
    );
  }

  nameText() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: FutureBuilder(
        future: Session.getUser(),
        builder: (context, userData) {
          if (userData.hasData) {
            user = userData.data;
            print(user.email);
            return Text(
              userData.data.displayName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  countryText() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: FutureBuilder(
        future: Session.getUser(),
        builder: (context, userData) {
          if (userData.hasData) {
            user = userData.data;
            print(user.email);
            return Text(
              user.countryName,
              style: TextStyle(
                color: Color.fromARGB(150, 255, 255, 255),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  body() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return offers[index];
      },
      itemCount: offers.length,
      padding: EdgeInsets.only(top: 8, bottom: 8),
    );
  }

  getFavoriteOffers() {
    Session.getAccessToken().then((token) {
      Network.getFavoriteOffers(token).then((offersList) {
        setState(() {
          offers = offersList.offers
              .map((offer) => OfferWidget(
                    offer: offer,
                  ))
              .toList();
        });
      });
    });
  }
}
