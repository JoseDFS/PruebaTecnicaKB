import 'dart:convert';

import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';
import 'package:prueba_tecnica_kb/data/api_service.dart';
import 'package:prueba_tecnica_kb/data/models/either_generic_response.dart';
import 'package:prueba_tecnica_kb/data/models/error_model.dart';
import 'package:prueba_tecnica_kb/data/models/generic_success_response.dart';

class AuthService {
  Future<EitherGenericResponse> login({required String username, required String password}) async {
    final apiService = ApiService(
      basePath: AppConfiguration.instance.endpoints.kAPIBaseUrlFakeStore,
      method: Method.post,
      showError: true,
    );

    var body = {"username": username, "password": password};
    var apiResponse = await apiService.sendRequest(url: AppConfiguration.instance.endpoints.kApiFakeLogin, body: body);
    if (apiResponse.hasError) {
      return EitherGenericResponse.left(ErrorModel(
        statusCode: apiResponse.statusCode.toString(),
        userMessage: apiResponse.errorUserMessage,
      ));
    }

    if (apiResponse.statusCode != 200) {
      return EitherGenericResponse.left(ErrorModel(
        statusCode: apiResponse.statusCode.toString(),
        userMessage: apiResponse.errorUserMessage,
      ));
    }

    try {
      return EitherGenericResponse.right(GenericSuccessResponse(data: json.decode(apiResponse.strResponse)));
    } on Exception catch (e) {
      return EitherGenericResponse.left(ErrorModel(statusCode: '500', exception: e));
    }
  }
}
