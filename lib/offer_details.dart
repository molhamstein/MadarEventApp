import 'package:al_madar/NewsList.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/offersList.dart';
import 'package:flutter/material.dart';

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
                IconButton(icon: Icon(icon), onPressed: setFavorite)
              ],
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.offer.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  widget.offer.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 16, right: 16,),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${widget.offer.period} ${MadarLocalizations.of(context).trans('days')}",
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.offer.content),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setFavorite() {

    Session.getAccessToken().then((token) {
      print('token = ' + token);
      if (!isFav) {
        Network.setOfferFavorite(widget.offer.id, token).then((isAdded) {
          if (isAdded) {
            setState(() {
              icon = Icons.favorite;
              isFav = true;
            });
          }
        });
      }
      else {
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
