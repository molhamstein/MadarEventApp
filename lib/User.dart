class User {
  String displayName;
  String email;
  String phone;
  String authToken;
  int countryId;
  String googleId;
  String facebookId;
  String address;
  String profession;
  String city;
  String snapchatHandle;
  String instagramHandle;
  String twitterHandle;
  String countryName;

  User(
      this.displayName,
      this.email,
      this.phone,
      this.authToken,
      this.countryId,
      this.googleId,
      this.facebookId,
      this.address,
      this.profession,
      this.city,
      this.snapchatHandle,
      this.instagramHandle,
      this.twitterHandle,
      this.countryName);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['DisplayName'],
      json['Email'],
      json['Mobile'],
      json['AuthToken'],
      json['CountryId'],
      json['GoogleId'],
      json['FacebookId'],
      json['Address'],
      json['Profession'],
      json['City'],
      json['SnapchatHandle'],
      json['InstagramHandle'],
      json['TwitterHandle'],
      json['CountryName'],
    );
  }

  @override
  String toString() {
    return 'User{displayName: $displayName, email: $email, phone: $phone, authToken: $authToken, countryId: $countryId, googleId: $googleId, facebookId: $facebookId, address: $address, profession: $profession, city: $city, snapchatHandle: $snapchatHandle, instagramHandle: $instagramHandle, twitterHandle: $twitterHandle, countryName: $countryName}';
  }


}
