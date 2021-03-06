import 'package:al_madar/User.dart';
import 'package:al_madar/edit_password.dart';
import 'package:al_madar/edit_profile.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/offer_details.dart';
import 'package:al_madar/offersList.dart';
import 'package:al_madar/widgets/offer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() {
    return new ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  List<OfferWidget> offerWidgets = [];
  List<Offer> offers = [];
  List<String> menuItems = [];
  bool empty;

  User user;

  @override
  void initState() {
    empty = false;
    Session.getUser().then((user) {
      print(user.toString());
      if (user.facebookId != null || user.googleId != null) {
        setState(() {
          menuItems.add('edit_profile');
        });
      } else {
        setState(() {
          menuItems.add('edit_profile');
          menuItems.add('edit_password');
        });
      }
    });
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
                color: Theme.of(context).primaryColorDark,
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
    if (empty) {
      return Container(
        child: Center(
          child: Text(MadarLocalizations.of(context).trans('empty_profile')),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: offerWidgets[index],
            onTap: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OfferDetails(
                        offer: offers[index],
                      ),
                ),
              );
              getFavoriteOffers();
            },
          );
        },
        itemCount: offerWidgets.length,
        padding: EdgeInsets.only(top: 8, bottom: 8),
      );
    }
  }

  getFavoriteOffers() {
    Session.getAccessToken().then((token) {
      Network.getFavoriteOffers(token).then((offersList) {
        setState(() {
          if (offersList.offers.isEmpty) empty = true;
          offers = offersList.offers;
          offerWidgets = offersList.offers
              .map((offer) => OfferWidget(
                    offer: offer,
                  ))
              .toList();
        });
      });
    });
  }
}
