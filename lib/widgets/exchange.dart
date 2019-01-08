import 'package:al_madar/exchangeList.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:flutter/material.dart';

class Exchange extends StatelessWidget {

  final ExchangeData data;

  const Exchange({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  data.code,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Text(
              "${data.rate.toStringAsFixed(1)}",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 42,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              MadarLocalizations.of(context).trans('1_lira'),
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey[400],
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
