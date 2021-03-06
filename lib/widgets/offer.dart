import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/main.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/offersList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class OfferWidget extends StatefulWidget {
  final Offer offer;

  const OfferWidget({Key key, this.offer}) : super(key: key);

  @override
  OfferWidgetState createState() {
    return new OfferWidgetState();
  }
}

class OfferWidgetState extends State<OfferWidget> {
  IconData icon;

  @override
  void initState() {
    icon = widget.offer.favorite ? Icons.favorite : Icons.favorite_border;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currencyCode =
        MadarLocalizations.of(context).trans(widget.offer.currencyCode) == null
            ? widget.offer.currencyCode
            : MadarLocalizations.of(context).trans(widget.offer.currencyCode);

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[600],
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 1),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              child: Image.network(
                widget.offer.imageUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          widget.offer.title,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Container(
                        child: Transform.rotate(
                          angle: 0.34,
                          child: IconButton(
                            icon: Icon(icon),
                            color: Theme.of(context).primaryColor,
                            iconSize: 32,
                            onPressed: setFavorite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.offer.period,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
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
                  ),
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          height: 120,
                          child: HtmlView(
                            data: widget.offer.content,
                          ),
                        ),
                      ),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            height: 130,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  setFavorite() {
    Session.getAccessToken().then((token) {
      if (loggedIn) {
        if (!widget.offer.favorite) {
          Network.setOfferFavorite(widget.offer.id, token).then((isAdded) {
            if (isAdded) {
              setState(() {
                icon = Icons.favorite;
              });
            }
          });
        } else {
          Network.removeOfferFavorite(widget.offer.id, token).then((removed) {
            if (removed) {
              setState(() {
                icon = Icons.favorite_border;
              });
            }
          });
        }
      } else {
        Navigator.of(context).pushNamed('/registrationScreen');
      }
    });
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double radius;

  TicketClipper(this.radius);

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: radius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
