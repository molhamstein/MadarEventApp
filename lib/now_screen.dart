import 'package:al_madar/exchangeList.dart';
import 'package:al_madar/madarLocalizer.dart';
import 'package:al_madar/network.dart';
import 'package:al_madar/widgets/exchange.dart';
import 'package:al_madar/widgets/weatherWidget.dart';
import 'package:flutter/material.dart';

class NowScreen extends StatefulWidget {
  @override
  NowScreenState createState() {
    return new NowScreenState();
  }
}

class NowScreenState extends State<NowScreen>
    with AutomaticKeepAliveClientMixin<NowScreen> {
  List<Exchange> exchangeWidgets = [];
  double rightPadding = 16; // gridView bug
  double leftPadding = 16; // gridView bug

  @override
  void initState() {
//    getRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (MadarLocalizations.of(context).locale.languageCode == 'ar') {
      rightPadding = 32;
      leftPadding = 0;
    }
    return Material(
      color: Colors.transparent,
      child: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                padding: EdgeInsets.only(
                    right: rightPadding,
                    top: 16,
                    bottom: 16,
                    left: leftPadding),
                children: <Widget>[
                  Weather(
                      'Istanbul',
                      'http://api.openweathermap.org/data/2.5/weather?q=Istanbul,tr&APPID=d9f1f0a14efb6a52c3c76bca2bb41c10',
                      'assets/images/istanbul.png'),
                  Weather(
                      'Izmir',
                      'http://api.openweathermap.org/data/2.5/weather?APPID=d9f1f0a14efb6a52c3c76bca2bb41c10&q=Izmir,tr',
                      'assets/images/izmir.jpg'),
                  Weather(
                      'Ankara',
                      'http://api.openweathermap.org/data/2.5/weather?q=Ankara,tr&APPID=d9f1f0a14efb6a52c3c76bca2bb41c10',
                      'assets/images/ankara.jpg'),
                  Weather(
                      'Bursa',
                      'http://api.openweathermap.org/data/2.5/weather?APPID=d9f1f0a14efb6a52c3c76bca2bb41c10&q=Bursa,tr',
                      'assets/images/bursa.jpg'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    MadarLocalizations.of(context).trans('exchange_rate_text'),
                    style: TextStyle(fontWeight: FontWeight.w800)),
              ),
              FutureBuilder<ExchangeList>(
                future: Network.getExchangeRates(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      color: Colors.transparent,
                      height: 150,
                      child: ListView(
                        shrinkWrap: true,
                        children: snapshot.data.data
                            .map((rate) => Exchange(data: rate))
                            .toList(),
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  }
                  return Container(
                    height: 150,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  getRates() {
    Network.getExchangeRates().then((rates) {
      setState(() {
        exchangeWidgets =
            rates.data.map((rate) => Exchange(data: rate)).toList();
      });
    });
  }

  Future<void> refresh() {
    return Network.getExchangeRates().then((rates) {
      setState(() {
        exchangeWidgets =
            rates.data.map((rate) => Exchange(data: rate)).toList();
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
