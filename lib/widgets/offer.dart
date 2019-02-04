import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/network/session.dart';
import 'package:al_madar/offersList.dart';
import 'package:flutter/material.dart';

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
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            widget.offer.title,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Transform.rotate(
                          angle: 0.34,
                          child: IconButton(
                            icon: Icon(icon),
                            color: Theme.of(context).primaryColor,
                            iconSize: 32,
                            onPressed: setFavorite,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.offer.period,
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
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      widget.offer.content,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
      print('token = ' + token);
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
