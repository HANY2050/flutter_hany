import 'dart:convert';

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:connectivity/connectivity.dart';
import 'package:generalshops/customer/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_util.dart';

//lllllllllllllllllllll
class UserApi {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<User>> fetchUser() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      var cacheData = await APICacheManager().getCacheData('API_USER');
      print("CACHE");
//kk
      List<User> users = [];
      var body = jsonDecode(cacheData.syncData);
      for (var item in body['data']) {
        users.add(User.fromJson(item));
      }
      return users;
    } else {
      await APICacheManager().isAPICacheKeyExist('API_USER');
      await checkInternet();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String apiToken = sharedPreferences.get('api_token');
      print("URL");
      Map<String, String> authHeaders = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + apiToken
      };
      String url = ApiUtl.SHOE_USER;
      http.Response response =
          await http.get(Uri.parse(url), headers: authHeaders);

      List<User> users = [];
      if (response.statusCode == 200) {
        // print(response.statusCode);
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          users.add(User.fromJson(item));
        }
        return users;
      }
      return null;
    }
  }
}
