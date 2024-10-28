import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Ensure this import is present
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/controllers/produc_list_controller.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productListController = ProductListController.instance;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => {
        productListController.goToProductDetailPage(product),
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Hero(
                  tag: product.id.toString(),
                  child: SizedBox(
                      height: 100.w,
                      width: 100.w,
                      child: product.image.isEmpty
                          ? const SizedBox.shrink()
                          : CachedNetworkImage(
                              imageUrl: product.image,
                              placeholder: (context, url) => const SpinKitCubeGrid(
                                duration: Duration(seconds: 1),
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '\$${product.price}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 12,
                                height: 12,
                                child: Icon(Icons.star, size: 12, color: Colors.yellow[700]),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${product.rating} / 5',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${product.reviews} opiniones',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
