import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pingo/models/NewsModel.dart';

class NewsService {
  final String _apiKey = 'd138e600d75241c09b1e03f0ede1c5b1';

  Future<News> fetchTopHeadlines(String country) async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=$country&apiKey=$_apiKey'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      News newsData = News.fromJson(data);
      return newsData;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
