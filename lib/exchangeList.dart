class ExchangeList {

  List<ExchangeData> data;

  ExchangeList(this.data);

  factory ExchangeList.fromJson(Map<String, dynamic> json) {
    final list = json['Rates'] as List;
    return ExchangeList(
      list.map((jsonRate) => ExchangeData.fromJson(jsonRate)).toList());
  }

}

class ExchangeData {

  String code;
  double rate;

  ExchangeData(this.code, this.rate);

  factory ExchangeData.fromJson(Map<String, dynamic> json) {
    return ExchangeData(
      json['CurrencyCode'],
      json['Rate']
    );
  }
}