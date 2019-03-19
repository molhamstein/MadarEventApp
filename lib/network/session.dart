import 'package:al_madar/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future setUser(User user) async {
    print(user.email);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', user.authToken);
    prefs.setString('DisplayName', user.displayName);
    prefs.setString('Email', user.email);
    prefs.setString('Mobile', user.phone);
    prefs.setInt('CountryId', user.countryId);
    prefs.setString('GoogleId', user.googleId);
    prefs.setString('FacebookId', user.facebookId);
    prefs.setString('Address', user.address);
    prefs.setString('Profession', user.profession);
    prefs.setString('City', user.city);
    prefs.setString('SnapchatHandle', user.snapchatHandle);
    prefs.setString('InstagramHandle', user.instagramHandle);
    prefs.setString('TwitterHandle', user.twitterHandle);
    prefs.setString('CountryName', user.countryName);
  }

  static Future setUserFromFacebook(
      String name, String email, String facebookId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('DisplayName', name);
    prefs.setString('Email', email);
    prefs.setString('FacebookId', facebookId);
  }

  static Future setUserFromGoogle(
      String name, String email, String googleId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('DisplayName', name);
    prefs.setString('Email', email);
    prefs.setString('GoogleId', googleId);
  }

  static Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return User(
      prefs.getString('DisplayName'),
      prefs.getString('Email'),
      prefs.getString('Mobile'),
      prefs.getString('access_token'),
      prefs.getInt('CountryId'),
      prefs.getString('GoogleId'),
      prefs.getString('FacebookId'),
      prefs.getString('Address'),
      prefs.getString('Profession'),
      prefs.getString('City'),
      prefs.getString('SnapchatHandle'),
      prefs.getString('InstagramHandle'),
      prefs.getString('TwitterHandle'),
      prefs.getString('CountryName'),
    );
  }

  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<bool> isLoggedOn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token')?.isNotEmpty ?? false;
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future setCountryName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('country', name);
  }

  static Future setWhatsappPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('whatsAppPhone', phone);
  }

  static Future<String> getWhatsappPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('whatsAppPhone');
  }

  static Future<String> getCountryName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('country');
  }
}
