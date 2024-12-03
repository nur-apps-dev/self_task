import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selef_task/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Product App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/products', page: () => ProductListPage()),
      ],
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed('/products',preventDuplicates: false); // Navigate to the ProductListPage
        },
        child: Text("Product List"),
      ),
    );
  }
}