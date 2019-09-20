import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_demo/helper/validation.dart';

class LoginViewModel {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _btnLogin = BehaviorSubject<bool>();

  var emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(Validation.validateEmail(email));
  });
  var passValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add(Validation.validatePassword(pass));
  });

  Stream<String> get emailStream => _email.stream.transform(emailValidation);

  Sink<String> get emailSink => _email.sink;

  Stream<String> get passStream => _password.stream.transform(passValidation);

  Sink<String> get passSink => _password.sink;

  Stream<bool> get btnLoginStream => _btnLogin.stream;

  Sink<bool> get btnLoginSink => _btnLogin.sink;

  LoginViewModel() {
    Observable.combineLatest2(_email, _password, (email, pass) {
      return Validation.validateEmail(email) == null &&
          Validation.validatePassword(pass) == null;
    }).listen((enable) {
      btnLoginSink.add(enable);
    });
  }

  dispose() {
    _email.close();
    _password.close();
    _btnLogin.close();
  }
}
