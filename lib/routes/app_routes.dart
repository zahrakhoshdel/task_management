// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const LOGIN = _Paths.LOGIN;
  static const SIGN_UP = _Paths.SIGN_UP;
  static const HOME = _Paths.HOME;
  //static const TASKS = _Paths.TASKS;
}

abstract class _Paths {
  static const LOGIN = '/login';
  static const SIGN_UP = '/sign-up';
  static const HOME = '/';
  //static const TASKS = '/tasks';
}
