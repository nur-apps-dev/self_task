
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart'; // Import your controller
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart'; // Import your product controller

class ProductListPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final ScrollController _scrollController = ScrollController();

  ProductListPage({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 &&
          !productController.isFetchingMore.value &&
          !productController.isLoading.value) {
        productController.fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    bool isSmallScreen = screenWidth < 600; // Small screen if width is less than 600

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List (10 Items/Page)'),
      ),
      body: Obx(() {
        if (productController.isLoading.value && productController.products.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else if (productController.errorMessage.isNotEmpty &&
            productController.products.isEmpty) {
          return Center(child: Text(productController.errorMessage.value));
        } else {
          return RefreshIndicator(
            onRefresh: () async => productController.fetchProducts(isRefresh: true),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: productController.products.length + 1,
              itemBuilder: (context, index) {
                if (index < productController.products.length) {
                  final product = productController.products[index];

                  double imageWidth = isSmallScreen ? screenWidth * 0.2 : 50;
                  double imageHeight = isSmallScreen ? screenWidth * 0.2 : 50;

                  double titleFontSize = isSmallScreen ? 14.0 : 18.0;
                  double subtitleFontSize = isSmallScreen ? 12.0 : 14.0;
                  EdgeInsetsGeometry padding = isSmallScreen ? EdgeInsets.symmetric(horizontal: 8.0) : EdgeInsets.symmetric(horizontal: 16.0);

                  return Padding(
                    padding: padding,
                    child: ListTile(
                      leading: Image.network(
                        product.imageUrl,
                        width: imageWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        product.title,
                        style: TextStyle(fontSize: titleFontSize),
                      ),
                      subtitle: Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: subtitleFontSize),
                      ),
                    ),
                  );
                }

                else if (productController.isFetchingMore.value) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                else if (productController.errorMessage.value == 'No more products to load.') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        productController.errorMessage.value,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  );
                }
                else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          );
        }
      }),
    );
  }
}
