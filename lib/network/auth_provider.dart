import 'dart:convert';
import 'package:al_madar/User.dart';
import 'package:al_madar/country_list.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<User> login(String userName, String password) async {
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
      throw Exception('Failed to load');
    }
  }

  Future<User> signUp(
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
      throw Exception(response.body.toString());
    }
  }

  static Future<CountryList> getCountries() async {
    var body = json.encode({
      "APIKEY": "SD<DJF<JDJD<",
    });
    final response = await http.post(
      'https://almadar.azurewebsites.net/Services/CountryAPI/GetCountries',
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return CountryList.fromJson(json.decode(response.body)); //String
    } else {
      throw Exception(response.body.toString());
    }
  }
}
