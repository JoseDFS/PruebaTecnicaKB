import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/local_widgets/image_hidden_appbar_widget.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/local_widgets/image_on_view_appbar_widget.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    this.product,
  });

  final ProductModel? product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _scrollController = ScrollController();
  bool isImageOnView = true;
  bool _isDescriptionExpanded = false;
  bool _isStoresExpanded = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.54;
      if (currentScroll > delta) {
        setState(() {
          isImageOnView = false;
        });
      } else {
        setState(() {
          isImageOnView = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return const Center(child: Text('Producto no encontrado'));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Hero(
                          tag: widget.product!.id.toString(),
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CachedNetworkImage(
                                imageUrl: widget.product!.image,
                                placeholder: (context, url) => const SpinKitCubeGrid(
                                  duration: Duration(seconds: 1),
                                  color: Colors.grey,
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 32.w),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: Text(
                                      widget.product!.title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 16.w),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: Text(
                                      '\$${widget.product!.price}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Icon(Icons.star, color: Colors.yellow[700]),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          '${widget.product!.rating} / 5',
                                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          '${widget.product!.reviews} opiniones',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w400,
                                            decorationColor: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                widget.product!.description,
                                                style: const TextStyle(fontSize: 20, color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                reverseDuration: const Duration(seconds: 0),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: child);
                },
                child: isImageOnView
                    ? const ImageOnViewAppBarWidget()
                    : ImageHiddenAppBarWidget(
                        image: widget.product!.image,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
