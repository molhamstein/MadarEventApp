class WeatherData {

  String description;
  String icon;
  double temp;

  WeatherData(this.description, this.icon, this.temp);

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    print(json);
    final weather = json['weather'][0];
    final temp = json['main'];
    return WeatherData(
      weather['description'],
      "https://openweathermap.org/img/w/${weather['icon']}.png",
      temp['temp'],
    );
  }

}