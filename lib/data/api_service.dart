import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';
import 'package:prueba_tecnica_kb/data/api_response_mixin.dart';
import 'package:prueba_tecnica_kb/data/models/api_response.dart';
import 'package:prueba_tecnica_kb/ui/widgets/alert_modal.dart';

enum Method { get, post, put, delete }

class ApiService with ApiResponseMixin {
  ApiService({
    required this.basePath,
    this.method = Method.get,
    this.showError = true,
    this.timeout = 30,
    this.okCodes = const [200],
    this.titleMessage = 'Tuvimos un problema',
    this.errorMessage = 'Error inesperado, compruebe su conexión a internet',
    this.timeoutMessage = 'Tiempo agotado',
    this.shouldReset = false,
  });
  Method method;
  String basePath;
  bool showError;
  Function? onError;
  int timeout;
  List<int> okCodes;
  String titleMessage;
  String errorMessage;
  String timeoutMessage;
  bool shouldReset = false;
  final http.Client httpClient = http.Client();
  final NavigatorState? nav = AppConfiguration.instance.nav;

  Future<ApiResponse> sendRequest({required String url, Map? body}) async {
    var apiResponse = ApiResponse();
    apiResponse.timeout = timeout;
    apiResponse.showError = showError;
    apiResponse.okCodes = okCodes;


    /// Se generan los headers del request
    var headers = {
      'Content-Type': 'application/json',
    };

    try {
      var strRequest = json.encode(body);
      log(strRequest);

      /// Configuramos el Request
      var futureReq = _getFutureRequest(basePath, url, headers, strRequest);

      /// Agregamos timeout si se configuró
      if (timeout > 0) {
        futureReq =
            futureReq.timeout(Duration(seconds: timeout), onTimeout: () => Future.value(http.Response('', 408)));
      }

      final httpResponse = await futureReq;
      apiResponse.statusCode = httpResponse.statusCode;

      /// se valida toda la respuesta
      processRequest(apiResponse, httpResponse);
    } catch (e) {
      log('Error -> $e');
      catchResponse(apiResponse, Exception(e));
    }

    /// se muestra el error en caso de existir y de haber sido requerido
    if (apiResponse.hasError && showError) {
      if (apiResponse.statusCode == 401 || apiResponse.statusCode == 403) {
        await nav?.push(AlertModal(
          title: 'Usuario o contraseña incorrectos',
          message: apiResponse.errorUserMessage,
          yesFunction: onError ?? () {},
          type: AlertType.error,
          yesText: 'Entendido',
        ));
      } else {
        await nav?.push(AlertModal(
          title: titleMessage,
          message: apiResponse.errorUserMessage,
          yesFunction: onError ?? () {},
          type: AlertType.error,
          yesText: 'Entendido',
        ));
      }
    }

    /// se hace el print de todo el http request
    _printAllRequest(
      url: url,
      headers: headers,
      method: method,
      body: body ?? {},
      response: apiResponse,
    );
    return apiResponse;
  }

  Future<http.Response> _getFutureRequest(
    String kAPIBaseUrl,
    String url,
    Map<String, String> headers,
    String strRequest,
  ) {
    final uri = Uri.parse(kAPIBaseUrl + url);
    if (method == Method.get) {
      return httpClient.get(uri, headers: headers);
    }
    if (method == Method.put) {
      return httpClient.put(uri, headers: headers, body: strRequest, encoding: Encoding.getByName('utf-8'));
    }
    return httpClient.post(uri, headers: headers, body: strRequest, encoding: Encoding.getByName('utf-8'));
  }

  void _printAllRequest({
    required String url,
    required Map headers,
    required Method method,
    required Map body,
    required ApiResponse response,
    Exception? e,
  }) {
    final logMessage = {
      'url': '$basePath$url',
      'headers': headers,
      'method': method,
      'body': body,
      'response': response.toMap(),
      'exception': e,
    };
    log(logMessage.toString());
  }
}
