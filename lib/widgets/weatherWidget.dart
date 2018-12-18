import 'package:al_madar/network.dart';
import 'package:al_madar/weather_data.dart';
import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  final String _title;
  final String _url;
  final String _image;

  Weather(this._title, this._url, this._image);

  @override
  WeatherState createState() {
    return new WeatherState();
  }
}

class WeatherState extends State<Weather> with TickerProviderStateMixin {

  WeatherData data;

  @override
  void initState() {
    data = WeatherData('-', '', 0);
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
              )
            ],
            image: DecorationImage(
              image: AssetImage(widget._image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.srcATop),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget._title,
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.black87,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    data.description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.network(data.icon),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "${(data.temp - 273.15).round()}", // Because Kelvin -.-"
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 42,
                        right: 8,
                      ),
                      child: Text(
                        'o',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getWeatherData() {
    Network.getWeatherData(widget._url).then((data) {
      setState(() {
        this.data = data;
      });
    });
  }
}
