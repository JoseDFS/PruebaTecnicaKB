import 'package:flutter/material.dart';
import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';

class ImageOnViewAppBarWidget extends StatelessWidget {
  const ImageOnViewAppBarWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
      ),
    );
  }
}
