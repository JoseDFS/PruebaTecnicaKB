import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prueba_tecnica_kb/core/conf/app_configuration.dart';
import 'package:prueba_tecnica_kb/ui/features/auth/views/login_page.dart';
import 'package:prueba_tecnica_kb/ui/features/product_list/views/product_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Prueba Técnica KB',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            useMaterial3: true,
          ),
          navigatorKey: AppConfiguration.instance.navKey, // Asigna el navKey
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginPage(title: 'Login'),
            '/products': (context) => const ProductListPage(),
          },
        );
      },
    );
  }
}
