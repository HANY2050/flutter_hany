import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:connectivity/connectivity.dart';
import 'package:generalshops/api/api_util.dart';
import 'package:generalshops/exceptions/exceptions.dart';
import 'package:generalshops/product/product.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ProductsApi {
  Map<String, String> headers = {'Accept': 'application/json'};
  Box box;
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  Future putData(data) async {
    await box.clear();
    for (var d in data) {
      box.add(d);
    }
  }

  Future<List<Product>> fetchProducts3(int page) async {
    String fileName = 'userdata.json';
    var dir = await getTemporaryDirectory();
    String url = ApiUtl.PRODUCTS + '?page=' + page.toString();
    /* String url = ApiUtl.PRODUCTS + '?page=' + page.toString();
    http.Response response = await http.get(Uri.parse(url), headers: headers);*/
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      print('not');
      var jsonData = file.readAsStringSync();
      List<Product> products = [];
      var body = jsonDecode(jsonData);
      for (var item in body['data']) {
        //  print(item);
        products.add(Product.fromJson(item));
      }
      return products;
    } else {
      await checkInternet();
      String url = ApiUtl.PRODUCTS + '?page=' + page.toString();
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      print("URL: HTIhh");
      List<Product> products = [];
      if (response.statusCode == 200) {
        // print(response.statusCode);
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          //  print(item);
          products.add(Product.fromJson(item));
        }
        file.writeAsString(response.body, flush: true, mode: FileMode.write);

        return products;
      }
      return null;
    }
  }

  Future<List<Product>> fetchProducts(int page) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      var cacheData = await APICacheManager().getCacheData('API_Product');
      print("CACHE: HTI");
      List<Product> products = [];
      var body = jsonDecode(cacheData.syncData);
      for (var item in body['data']) {
        //  print(item);
        products.add(Product.fromJson(item));
      }
      return products;
    } else {
      await APICacheManager().isAPICacheKeyExist('API_Product');
      await checkInternet();
      String url = ApiUtl.PRODUCTS + '?page=' + page.toString();
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      print("URL: HTI");

      List<Product> products = [];
      if (response.statusCode == 200) {
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: "API_Product", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);
        // print(response.statusCode);
        var body = jsonDecode(response.body);
        // print(body);
        for (var item in body['data']) {
          products.add(Product.fromJson(item));
        }
        return products;
      }
      return null;
    }
  }

  Future<List<Product>> fetchProducts2(int page) async {
    await checkInternet();
    String url = ApiUtl.PRODUCTS + '?page=' + page.toString();
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    print("URL: HTI");
    List<Product> products = [];
    if (response.statusCode == 200) {
      // print(response.statusCode);
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        //  print(item);
        products.add(Product.fromJson(item));
      }
      return products;
    }
    return null;
  }

  Future<List<Product>> fetchProductsByCategory(int category, int page) async {
    await checkInternet();
    String url = ApiUtl.CATEGORY_PRODUCTS(category, page);
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    List<Product> products = [];
    switch (response.statusCode) {
      case 404:
        throw ResourceNotFound('Products');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      case 200:
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          // print(item);
          products.add(Product.fromJson(item));
        }
        return products;
        break;
      default:
        return null;
        break;
    }
  }

  Future<Product> fetchProduct(int product_id) async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist('API_Product');
    if (!isCacheExist) {
      await checkInternet();
      String url = ApiUtl.PRODUCT + product_id.toString();
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      print("URL: HTI");
      if (response.statusCode == 200) {
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: "API_Product", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);
        var body = jsonDecode(response.body);
        return Product.fromJson(body['data']);
      }
      return null;
    } else {
      var cacheData = await APICacheManager().getCacheData('API_Product');
      print("CACHE: HTI");

      var body = jsonDecode(cacheData.syncData);
      return Product.fromJson(body['data']);
    }
  }
}
