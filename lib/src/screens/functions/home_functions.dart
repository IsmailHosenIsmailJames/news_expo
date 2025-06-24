import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_expo/src/apis/apis.dart';
import 'package:news_expo/src/apis/keys.dart';
import 'package:news_expo/src/screens/models/saerch_res_model.dart';

class HomeFunctions {
  static Future<SearchResModel?> searchOverArticle(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SearchResModel.fromJson(response.body);
    } else {
      log(response.statusCode.toString(), name: "http");
      log(response.body, name: "http body");
      return null;
    }
  }

  static getSearchURL(String keyword, DateTime publishedAfter) {
    return "${baseAPI}v2/everything?q=$keyword&from=${DateFormat("yyyy-mm-dd").format(publishedAfter)}&sortBy=publishedAt&apiKey=$API_KEY";
  }
}
