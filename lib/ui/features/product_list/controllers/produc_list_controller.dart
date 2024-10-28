import 'package:flutter/material.dart';
import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/models/product_model.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/service/product_list_service.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/views/product_detail_page.dart';
import 'package:rxdart/rxdart.dart';

class ProductListController {
  static final ProductListController instance = ProductListController();
  final ProductListService productListService = ProductListService();

  final _productList = BehaviorSubject<List<ProductModel>>();

  Stream<List<ProductModel>> get productsStream => _productList.stream;

  void getProducts() async {
    var response = await productListService.getProducts();
    if (response.isRight()) {
      _productList.add(response.right ?? []);
    }
  }

  void goToProductDetailPage(ProductModel product) {
    AppConfiguration.instance.nav?.push(MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)));
  }
}
