import 'dart:convert';

import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';
import 'package:prueba_tecnica_kb/data/api_service.dart';
import 'package:prueba_tecnica_kb/data/daos/product_dao.dart';
import 'package:prueba_tecnica_kb/data/models/either_model.dart';
import 'package:prueba_tecnica_kb/data/models/error_model.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/models/product_model.dart';

class ProductListService {
  Future<EitherModel<List<ProductModel>>> getProducts() async {
    final apiService = ApiService(
      basePath: AppConfiguration.instance.endpoints.kAPIBaseUrlFakeStore,
      showError: true,
    );

    var apiResponse = await apiService.sendRequest(url: AppConfiguration.instance.endpoints.kApiFakeProducts);
    if (apiResponse.hasError) {
      return EitherModel.left(ErrorModel(
        statusCode: apiResponse.statusCode.toString(),
        userMessage: apiResponse.errorUserMessage,
      ));
    }

    if (apiResponse.statusCode != 200) {
      return EitherModel.left(ErrorModel(
        statusCode: apiResponse.statusCode.toString(),
        userMessage: apiResponse.errorUserMessage,
      ));
    }

    try {
      List<ProductDao> productsDao =
          (json.decode(apiResponse.strResponse) as List).map((product) => ProductDao.fromJson(product)).toList();
      List<ProductModel> products = productsDao.map((product) => ProductModel.fromDao(product)).toList();
      return EitherModel.right(products);
    } on Exception catch (e) {
      return EitherModel.left(ErrorModel(statusCode: '500', exception: e));
    }
  }
}
