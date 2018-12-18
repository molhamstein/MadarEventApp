import 'package:al_madar/User.dart';
import 'package:al_madar/bloc/base_bloc.dart';
import 'package:al_madar/country_list.dart';
import 'package:al_madar/network/session.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BaseBloc {
  final _doLogin = PublishSubject<User>();
  final _loggedOut = PublishSubject<bool>();
  final _signUpMsg = PublishSubject<User>();
  final _countries = PublishSubject<CountryList>();

  Stream<User> get getUser => _doLogin.stream;
  Stream<User> get getSignUpUser => _signUpMsg.stream;
  Stream<CountryList> get getCountries => _countries.stream;

  login(String userName, String password) async {
    User user = await repository.login(userName, password);
    Session.setUser(user);
    _doLogin.sink.add(user);
  }

  signUp(String displayName, String email, String mobile, String password) async {
    User user = await repository.signUp(
        displayName, email, mobile, password);
    _signUpMsg.sink.add(user);
  }

  fetchCountries() async {
    CountryList list = await repository.fetchCountries();
    _countries.sink.add(list);
  }

  logout() {
    repository.logout();
    _loggedOut.sink.add(true);
  }

  @override
  dispose() {
    _doLogin.close();
    _loggedOut.close();
    _signUpMsg.close();
    _countries.close();
    super.dispose();
  }
}
