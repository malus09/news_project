import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../modal/newsModal.dart';

class NewsApi {
  Future<List<News>> findNewsByName() async {
    String key = '7dd4d824ec624d2c9a5bfb6c85a662cc';
    Uri url = Uri.parse(
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=$key');

    Response response = await http.get(url);
    List<News> newsList = [];

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['articles'];
      newsList = jsonList.map((json) => News.fromJson(json)).toList();
    }

    return newsList;
  }
}
