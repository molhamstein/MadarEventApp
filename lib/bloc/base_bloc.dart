import 'package:al_madar/network/repository.dart';
import 'package:rxdart/rxdart.dart';

class BaseBloc {

  final _repository = Repository();
  final _shouldLoad = PublishSubject<bool>();
  final _userLoggedOn = BehaviorSubject<bool>();


  get shouldShowLoader => _shouldLoad.stream;
  get isUserLoggedOn => _userLoggedOn.stream;
  get repository => _repository;

  startLoad() => _shouldLoad.sink.add(true);

  stopLoad() => _shouldLoad.sink.add(false);


  userLoggedIn() async => _userLoggedOn.sink.add( await _repository.isUserLoggedOn());

  dispose() {
    _shouldLoad.close();
    _userLoggedOn.close();
  }
}