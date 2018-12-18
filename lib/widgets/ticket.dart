import 'dart:math';
import 'dart:ui';

import 'package:al_madar/NewsList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Ticket extends StatefulWidget {
  final Post post;

  const Ticket({Key key, this.post}) : super(key: key);


  @override
  TicketState createState() {
    return new TicketState();
  }
}

class TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(right: 24, left: 24, top: 8, bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
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
                widget.post.imageUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 16, bottom: 24, left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(getDate(), style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.grey[600]),)
                      ],
                    ),
                  ),
                  Text(
                    widget.post.title,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      widget.post.content,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[800],
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

  getDate() {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(DateTime.parse(widget.post.date));
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

    path.addArc(
        Rect.fromCircle(
            center: Offset(size.width, size.height / 2), radius: radius),
        0.5 * pi,
        pi);
    path.addArc(
        Rect.fromCircle(center: Offset(0, size.height / 2), radius: radius),
        1.5 * pi,
        pi);
//
//    path.addOval(
//        Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: radius));
//    path.addOval(Rect.fromCircle(
//        center: Offset(size.width, size.height / 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
