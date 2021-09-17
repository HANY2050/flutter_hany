import 'dart:async';
import 'dart:core';

import 'package:generalshops/api/products_api.dart';
import 'package:generalshops/contracts/contracts.dart';
import 'package:generalshops/product/product.dart';

class HomeProductBloc implements Disposable {
  List<Product> products;
  ProductsApi productsApi;
  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>.broadcast();
  final StreamController<int> _categoryController =
      StreamController<int>.broadcast();

  Stream<List<Product>> get productsStream => _productsController.stream;
  StreamSink<int> get fetchProducts => _categoryController.sink;
  Stream<int> get category => _categoryController.stream;
  int categoryID;
  int page = 1;

  HomeProductBloc() {
    this.products = [];

    productsApi = ProductsApi();
    _productsController.add(this.products);
    _categoryController.add(this.categoryID);
    _categoryController.stream.listen(_fetchCategoriesFromApi);
  }

  Future<void> _fetchCategoriesFromApi(int category) async {
    this.products = await productsApi.fetchProductsByCategory(category, page);
    //for (int i = this.page; i > 0; i++)
    // await Future.delayed(Duration(seconds: 1));

    _productsController.add(this.products);
  }

  Future<void> _fetchCategoriesFromApi2(int category) async {
    this.products = await productsApi.fetchProductsByCategory(category, page++);

    // await Future.delayed(Duration(seconds: 1));

    _productsController.add(this.products);
  }

  @override
  void dispose() {
    _productsController.close();
    _categoryController.close();
  }
}
