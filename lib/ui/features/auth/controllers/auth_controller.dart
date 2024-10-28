import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';
import 'package:prueba_tecnica_kb/data/models/either_generic_response.dart';
import 'package:prueba_tecnica_kb/ui/features/auth/service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthController {
  static final AuthController instance = AuthController();
  final AuthService authService = AuthService();

  final _isLoading = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isLoading => _isLoading.stream;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void init() {
    usernameController.clear();
    passwordController.clear();
  }


  Future<void> login() async {
    _isLoading.add(true);
    EitherGenericResponse response = await authService.login(
      username: usernameController.text,
      password: passwordController.text,
    );

    if (response.isRight()) {
      log('Login exitoso');
      AppConfiguration.instance.nav?.pushNamed('/products');
    } else {
      log('Login fallido');
      usernameController.clear();
      passwordController.clear();
    }
    _isLoading.add(false);
  }
}
