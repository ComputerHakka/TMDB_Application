import 'dart:async';

import 'package:cinema_app/domain/api_client/api_client.dart';
import 'package:cinema_app/domain/data_providers/session_data_provider.dart';
import 'package:cinema_app/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'Сервер недоступен. Проверьте подключение к Интернету';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Неправильный логин или пароль';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'Произошла ошибка, попробуйте ещё раз';
          break;
      }
    }

    _isAuthProgress = false;
    if (errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null) {
      _errorMessage = 'Неизвестная ошибка повторите попытку';
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen));
  }
}

// class AuthProvider extends InheritedNotifier {
//   final AuthModel model;
//   const AuthProvider({
//     super.key,
//     required this.model,
//     required super.child,
//   }) : super(
//           notifier: model,
//         );

//   static AuthProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//   }

//   static AuthProvider? read(BuildContext context) {
//     final widget =
//         context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
//     return widget is AuthProvider ? widget : null;
//   }

//   @override
//   bool updateShouldNotify(AuthProvider oldWidget) {
//     return true;
//   }
// }

