import 'dart:math';

import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/offer_details.dart';
import 'package:al_madar/widgets/offer.dart';
import 'package:flutter/material.dart';

class OffersScreen extends StatefulWidget {
  @override
  OffersScreenState createState() {
    return new OffersScreenState();
  }
}

class OffersScreenState extends State<OffersScreen>
    with AutomaticKeepAliveClientMixin<OffersScreen> {
  List<Widget> offers = [];

  @override
  void initState() {
    getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: refresh,
      child: offers.isNotEmpty
          ? ListView.builder(
              key: new Key(randomString(20)), //new
              itemBuilder: (BuildContext context, int index) {
                return offers[index];
              },
              itemCount: offers.length,
              padding: EdgeInsets.only(top: 8, bottom: 8),
            )
          : Container(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  getOffers() {
    Session.getAccessToken().then((token) {
      Network.getOffers(token).then((offersList) {
        setState(() {
          offers.clear();
          offers = offersList.offers.map((offer) {
            return InkWell(
              child: OfferWidget(
                offer: offer,
              ),
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OfferDetails(
                          offer: offer,
                        ),
                  ),
                );

                getOffers();
              },
            );
          }).toList();
        });
      });
    });
  }

  Future<void> refresh() async {
    await Session.getAccessToken().then((token) {
      return Network.getOffers(token).then((offersList) {
        setState(() {
          offers.clear();
          offers = offersList.offers.map((offer) {
            return InkWell(
              child: OfferWidget(
                offer: offer,
              ),
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OfferDetails(
                          offer: offer,
                        ),
                  ),
                );

                getOffers();
              },
            );
          }).toList();
        });
      });
    });
  }

  String randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });
    return new String.fromCharCodes(codeUnits);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
