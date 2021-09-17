import 'dart:convert';

import 'package:generalshops/exceptions/exceptions.dart';
import 'package:generalshops/order/orderModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_util.dart';

class OrderApi {
  Future<Order> order(
      String cart_id, String address, String city, double amount) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    String orderApi = ApiUtl.ADD_ORDER;
    Map<String, String> body = {
      'cart_id': cart_id.toString(),
      'address': address,
      'city': city,
      'amount': amount.toString(),
    };
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    http.Response response = await http.post(Uri.parse(ApiUtl.ADD_ORDER),
        headers: authHeaders, body: body);
    print(body);
    switch (response.statusCode) {
      case 200:
      case 201:
        break;
      case 404:
        throw ResourceNotFound('order');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<Order> orderT(
    String cart_id,
    String address,
    String city,
    double amount,
    String companyT,
    String nameT,
    String numberT,
  ) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    String orderApi = ApiUtl.ADD_ORDER_T;
    Map<String, String> body = {
      'cart_id': cart_id.toString(),
      'address': address,
      'city': city,
      'amount': amount.toString(),
      'companyT': companyT,
      'nameT': nameT,
      'numberT': numberT,
    };
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    http.Response response =
        await http.post(Uri.parse(orderApi), headers: authHeaders, body: body);
    print(body);
    switch (response.statusCode) {
      case 200:
      case 201:
        break;
      case 404:
        throw ResourceNotFound('orderT');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<Order> fetchOrder() async {
    await checkInternet();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    String Api = ApiUtl.SHOE_ORDERS;
    http.Response response =
        await http.get(Uri.parse(Api), headers: authHeaders);

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);

        return Order.fromJson(body['data']);

        break;
      default:
        throw ResourceNotFound('Order');
        break;
    }
  }

  Future<List<Order>> fetchO() async {
    await checkInternet();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    String Api = ApiUtl.SHOE_ORDERS;
    http.Response response =
        await http.get(Uri.parse(Api), headers: authHeaders);
    switch (response.statusCode) {
      case 200:
        List<Order> cartss = [];
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          print(body);
          for (var item in body['data']) {
            cartss.add(Order.fromJson(item));
          }
        }
        return cartss;

        break;
      case 404:
        throw ResourceNotFound('cartss');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      default:
        return null;
        break;
    }
  }
}
