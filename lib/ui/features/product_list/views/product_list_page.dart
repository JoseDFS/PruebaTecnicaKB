import 'package:flutter/material.dart';
import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/controllers/produc_list_controller.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/local_widgets/product_card_widget.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/models/product_model.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productListController = ProductListController.instance;
    productListController.getProducts();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                AppConfiguration.instance.nav?.pop();
              },
            ),
          ],
          title: const Text('Lista de productos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: StreamBuilder<List<ProductModel>>(
              stream: productListController.productsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<ProductModel> products = snapshot.data ?? [];
                if (products.isEmpty) {
                  return const Center(child: Text('No hay productos'));
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ProductCardWidget(product: products[index]),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
