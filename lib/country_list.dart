class CountryList {

  List<Country> countries;

  CountryList(this.countries);

  factory CountryList.fromJson(Map<String, dynamic> json) {
    final list = json['Countries'] as List;

    return CountryList(
      list.map((jsonCountry) => Country.fromJson(jsonCountry)).toList()
    );
  }


}

class Country {
  int id;
  String countryName;
  String countryNameAR;

  Country(this.id, this.countryName, this.countryNameAR);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['Id'],
      json['CountryName'],
      json['CountryName_Ar'],
    );
  }

}
