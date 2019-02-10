import 'dart:async';
import 'dart:convert';
import 'package:al_madar/NewsList.dart';
import 'package:al_madar/User.dart';
import 'package:al_madar/exchangeList.dart';
import 'package:al_madar/offersList.dart';
import 'package:al_madar/weather_data.dart';
import 'package:http/http.dart' as http;

class Network {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static  Future<User> login(String userName, String password) async {
    var body = json.encode({
      'UserName': userName,
      'Password': password,
      'APIKEY': 'SD<DJF<JDJD<',
    });
    final response = await http.post(
        'https://almadar.azurewebsites.net/Services/Administration/UserAPI/Login',
        body: body, headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return User.fromJson(json.decode(response.body)['LoggedInUser']);
    } else {
      print(response.body);
      throw json.decode(response.body);
    }
  }



  static Future<User> signUp(
      String displayName, String email, String mobile, String password) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "Entity": {
        'DisplayName': displayName,
        'Email': email,
        'Mobile': mobile,
        'Password': password,
      }
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/Administration/UserAPI/AddUser',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['LoggedInUser']); //String
    } else {
      throw json.decode(response.body);
    }
  }
  static Future<dynamic> signUpWithFacebook(
      String displayName, String email, String facebookId) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "Entity": {
        'DisplayName': displayName,
        'Email': email,
        'FacebookId': facebookId,
      }
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/Administration/UserAPI/AddUser',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.body.toString());
    }
  }

  static Future<dynamic> signUpWithGoogle(
      String displayName, String email, String googleId) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "Entity": {
        'DisplayName': displayName,
        'Email': email,
        'GoogleId': googleId,
      }
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/Administration/UserAPI/AddUser',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.body.toString());
    }
  }

  static Future<User> signUpAfterFacebookOrGoogle(User user) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": user.authToken,
      "Entity": {
        "DisplayName": user.displayName,
        "Email": user.email,
        "Mobile": user.phone,
        "CountryId": user.countryId,
        "GoogleId": user.googleId,
        "Address": user.address,
        "Profession": user.profession,
        "FacebookId": user.facebookId,
        "City": user.city,
        "SnapchatHandle": user.snapchatHandle,
        "InstagramHandle": user.instagramHandle,
        "TwitterHandle": user.twitterHandle,
      }
    });

    print(json.decode(body));

    final response = await http.post(
        'https://almadar.azurewebsites.net/Services/Administration/UserAPI/AddUser',
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
//      print(json.decode(response.body)['LoggedInUser']);
      print(json.decode(response.body));
      return User.fromJson(json.decode(response.body)['LoggedInUser']);
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<User> updateUser(User user) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": user.authToken,
      "Entity": {
        "DisplayName": user.displayName,
        "Email": user.email,
        "Mobile": user.phone,
        "CountryId": user.countryId,
        "GoogleId": user.googleId,
        "Address": user.address,
        "Profession": user.profession,
        "FacebookId": user.facebookId,
        "City": user.city,
        "SnapchatHandle": user.snapchatHandle,
        "InstagramHandle": user.instagramHandle,
        "TwitterHandle": user.twitterHandle,
      }
    });

    final response = await http.post(
        'https://almadar.azurewebsites.net/Services/Administration/UserAPI/UpdateUser',
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body)['LoggedInUser']);
      return User.fromJson(json.decode(response.body)['LoggedInUser']);
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<NewsList> getNews(String authToken) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": authToken,
    });
    final response = await http.post(
        'https://almadar.azurewebsites.net/Services/NewsManagement/NewsAPI/GetNews',
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      return NewsList.fromJson(json.decode(response.body));
    } else {
      throw json.decode(response.body);
    }
  }

  static Future<OffersList> getOffers(String authToken) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": authToken,
    });
    final response = await http.post(
        'https://almadar.azurewebsites.net/Services/OffersManagement/OffersAPI/GetOffers',
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      return OffersList.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<OffersList> getFavoriteOffers(String authToken) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": authToken,
    });
    final response = await http.post(
        'https://almadar.azurewebsites.net/Services/OffersManagement/OffersAPI/GetFavouritOffers',
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      return OffersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<bool> setOfferFavorite(int id, String authToken) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": authToken,
      "OfferId": id,
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/OffersManagement/OffersAPI/AddToFavorite',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<bool> removeOfferFavorite(int id, String authToken) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": authToken,
      "OfferId": id,
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/OffersManagement/OffersAPI/RemoveFromFavorite',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<ExchangeList> getExchangeRates() async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/GeneralSettings/CurrencyAPI/GetExchangeRates',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return ExchangeList.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<WeatherData> getWeatherData(String url) async {
    print(url);
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<dynamic> getFacebookProfile(String token) async {
    final response = await http.get(
      "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=" +
          token,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<bool> editPassword(
      String authToken, String password, String confirmPassword) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": authToken,
      "Password": password,
      "ConfirmPassword": confirmPassword,
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/Administration/UserAPI/ResetPassword',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }

  static Future<Null> submitForm(
      String authToken,
      String name,
      String phone,
      String destinationCity,
      String arrivalDate,
      String departureDate,
      String numberOfAdults,
      String numberOfChildren,
      String numberOfRooms,
      bool fromAirport,
      bool toAirport,
      bool cityTours,
      int hotelRating,
      String details) async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
      "AuthToken": authToken,
      "Message": {
        "Name": name,
        "Mobile": phone,
        "DestinationCity": destinationCity,
        "ArrivalDate": arrivalDate,
        "DepartureDate": departureDate,
        "NumberOfPeople": numberOfAdults,
        "NumberOfChildren": numberOfChildren,
        "NumberOfRooms": numberOfRooms,
        "PickupFromAirports": fromAirport,
        "TransportToAirport": toAirport,
        "CityTours": cityTours,
        "HotelRating": hotelRating,
        "Details": details
      }
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/CustomersManagement/TripAPI/SendMessage',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return;
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to load');
    }
  }
}
