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
  int period;
  double price;
  bool favorite;

  Offer(this.id, this.title, this.content, this.imageUrl, this.period, this.price, this.favorite);

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      json['Id'],
      json['OffersTitle'],
      json['OffersContent'],
      json['OffersImage'],
      json['OfferPeriod'],
      json['OfferPrice'],
      json['Favorite'],
    );
  }

}