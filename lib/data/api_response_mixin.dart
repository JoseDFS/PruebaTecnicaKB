import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba_tecnica_kb/data/models/api_response.dart';

const String genericErrorUserMessage = 'Problema con el servidor, por favor vuelve a intentarlo';

mixin ApiResponseMixin {
  ApiResponse timeoutResponse(ApiResponse apiResponse) {
    apiResponse.statusCode = 0;
    apiResponse.strResponse = 'timeout';
    apiResponse.completed = false;
    apiResponse.wasTimeout = true;
    apiResponse.hasError = true;
    return apiResponse;
  }

  ApiResponse catchResponse(ApiResponse apiResponse, Exception ex) {
    apiResponse.errorTechMessage = "Error - Exception error $ex";
    apiResponse.completed = false;
    apiResponse.statusCode = -1;
    apiResponse.hasError = true;
    apiResponse.exception = ex;
    return apiResponse;
  }

  ApiResponse processRequest(ApiResponse apiResponse, http.Response httpResponse) {
    /// Determinamos si existió timeout
    if (apiResponse.timeout > 0 && httpResponse.statusCode == 408) {
      timeoutResponse(apiResponse);
      apiResponse.hasError = true;
      apiResponse.errorTechMessage = 'Timeout';
      return apiResponse;
    }

    try {
      apiResponse.statusCode = httpResponse.statusCode;
      final encoding = Encoding.getByName('utf-8');
      if (encoding != null) {
        apiResponse.strResponse = encoding.decode(httpResponse.bodyBytes);
      }
      apiResponse.completed = true;
      apiResponse.wasTimeout = false;

      /// se valida posibles errores de acceso acceso
      if (apiResponse.statusCode == 401 || apiResponse.statusCode == 403) {
        apiResponse.showError = false;
        apiResponse.hasError = true;
        return apiResponse;
      }

      /// se valida error de entrada de datos
      if (apiResponse.statusCode == 400) {
        apiResponse.hasError = true;
        apiResponse.errorTechMessage = 'HTTP status 400 Bad Request';
        apiResponse.errorUserMessage = genericErrorUserMessage;
        return apiResponse;
      }

      /// se valida posibles errores tipo 500
      if (apiResponse.statusCode.toString().startsWith('5')) {
        apiResponse.hasError = true;
        apiResponse.errorUserMessage = genericErrorUserMessage;
        apiResponse.errorTechMessage = "Error - HTTP status code 5XX, server error";
        return apiResponse;
      }

      /// se valida que el código de respuesta no esté incluido entre los códigos válidos esperados
      if (apiResponse.showError && !apiResponse.okCodes.contains(apiResponse.statusCode)) {
        apiResponse.hasError = true;
        apiResponse.errorUserMessage = genericErrorUserMessage;
        return apiResponse;
      }

      /// se retorna respuesta OK
      return apiResponse;
    } catch (e) {
      catchResponse(apiResponse, Exception(e));
      return apiResponse;
    }
  }
}
