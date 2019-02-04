class OffersList {

  List<Offer> offers;

  OffersList(this.offers);

  factory OffersList.fromJson(Map<String, dynamic> json) {
    final list = json['Offers'] as List;
    return OffersList(
        list.map((jsonPost) => Offer.fromJson(jsonPost)).toList()
    );
  }

}

class Offer {
  int id;
  String title;
  String content;
  String imageUrl;
  String period;
  double price;
  bool favorite;
  String currencyCode;

  Offer(this.id, this.title, this.content, this.imageUrl, this.period, this.price, this.favorite, this.currencyCode);

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      json['Id'],
      json['OffersTitle'],
      json['OffersContent'],
      json['OffersImage'],
      json['OfferPeriodText'] == null ? "" : json['OfferPeriodText'],
      json['OfferPrice'],
      json['Favorite'],
      json['CurrencyCode'],
    );
  }

}