import 'dart:ui';

import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/offersList.dart';
import 'package:al_madar/widgets/full_screen_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class OfferDetails extends StatefulWidget {
  final Offer offer;

  const OfferDetails({Key key, this.offer}) : super(key: key);

  @override
  OfferDetailsState createState() {
    return new OfferDetailsState();
  }
}

class OfferDetailsState extends State<OfferDetails> {
  IconData icon;
  bool isFav;

  @override
  void initState() {
    isFav = widget.offer.favorite;
    icon = isFav ? Icons.favorite : Icons.favorite_border;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currencyCode =
        MadarLocalizations.of(context).trans(widget.offer.currencyCode) == null
            ? widget.offer.currencyCode
            : MadarLocalizations.of(context).trans(widget.offer.currencyCode);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    icon,
                  ),
                  onPressed: setFavorite,
                ),
              ],
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(widget.offer.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
                background: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FullScreenPicture(
                              imageUrl: widget.offer.imageUrl,
                            ),
                      ),
                    );
                  },
                  child: Hero(
                      tag: FullScreenPicture.tag,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.network(
                            widget.offer.imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.black26,
                                  Colors.transparent,
                                ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16,
            right: 16,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "${widget.offer.period}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "${widget.offer.price} " + currencyCode,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: HtmlView(
                  data: widget.offer.content,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  setFavorite() {
    Session.getAccessToken().then((token) {
      if (!isFav) {
        Network.setOfferFavorite(widget.offer.id, token).then((isAdded) {
          if (isAdded) {
            setState(() {
              icon = Icons.favorite;
              isFav = true;
            });
          }
        });
      } else {
        Network.removeOfferFavorite(widget.offer.id, token).then((removed) {
          if (removed) {
            setState(() {
              icon = Icons.favorite_border;
              isFav = false;
            });
          }
        });
      }
    });
  }
}
