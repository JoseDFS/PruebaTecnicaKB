import 'package:flutter/material.dart'; // Importa el paquete de Flutter
import 'package:prueba_tecnica_kb/core/conf/endpoint_conf.dart';

class AppConfiguration {
  static final AppConfiguration instance = AppConfiguration();
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  EndpointResource endpoints = EndpointResource();

  NavigatorState? get nav => navKey.currentState;
}
