
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart';

class ProductListPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height; // Screen height
    final sizeW = MediaQuery.of(context).size.width;  // Screen width

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
          style: TextStyle(fontSize: sizeH * 0.03), // Responsive font size
        ),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(
            child: SizedBox(
              width: sizeW * 0.1,
              height: sizeW * 0.1,
              child: CircularProgressIndicator(), // Responsive loader size
            ),
          );
        } else if (productController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              productController.errorMessage.value,
              style: TextStyle(fontSize: sizeH * 0.02), // Responsive error message size
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              final product = productController.products[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sizeW * 0.05, // Responsive horizontal padding
                  vertical: sizeH * 0.01,   // Responsive vertical padding
                ),
                child: ListTile(
                  leading: SizedBox(
                    width: sizeW * 0.15,  // Responsive image width
                    height: sizeH * 0.1, // Responsive image height
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    product.title,
                    style: TextStyle(fontSize: sizeH * 0.02), // Responsive font size
                  ),
                  subtitle: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: sizeH * 0.018), // Responsive font size
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
