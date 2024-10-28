import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';

class ImageHiddenAppBarWidget extends StatelessWidget {
  const ImageHiddenAppBarWidget({
    super.key,
    required this.image,
  });

  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: Colors.white,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: Row(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: () => AppConfiguration.instance.nav?.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) => const SpinKitCubeGrid(
                        duration: Duration(seconds: 1),
                        color: Colors.grey,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 56,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
