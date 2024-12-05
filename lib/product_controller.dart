

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_response_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var isFetchingMore = false.obs;
  var errorMessage = ''.obs;
  var currentPage = 1;
  final int itemsPerPage = 10;


  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      products.clear();
      errorMessage('');
    }

    if (isRefresh || currentPage == 1) {
      isLoading(true);
    } else {
      isFetchingMore(true);
    }

    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final start = (currentPage - 1) * itemsPerPage;
        final end = start + itemsPerPage;
        final paginatedData = data.sublist(
          start,
          end > data.length ? data.length : end,
        );


        if (paginatedData.isNotEmpty) {
          products.addAll(paginatedData.map((json) => Product.fromJson(json)).toList());
          currentPage++;
        } else if (isRefresh) {
          errorMessage('No products found.');
        } else {
          errorMessage('No more products to load.');
        }
      } else {
        errorMessage('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
      isFetchingMore(false);
    }
  }


  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
}
