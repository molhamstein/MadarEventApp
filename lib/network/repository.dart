import 'package:al_madar/User.dart';
import 'package:al_madar/country_list.dart';
import 'package:al_madar/network/auth_provider.dart';
import 'package:al_madar/network/session.dart';

class Repository {
  final _session = Session();
  final AuthProvider _authProvider = AuthProvider();

  get session => _session;

  Future<User> login(String userName, String password) =>
      _authProvider.login(userName, password);

  Future<User> signUp(
          String displayName, String email, String mobile, String password) =>
      _authProvider.signUp(displayName, email, mobile, password);

//  Future<CountryList> fetchCountries() => _authProvider.getCountries();

  Future<bool> isUserLoggedOn() {
    return _session.isLoggedOn();
  }

  Future logout() => _session.logout();
}
