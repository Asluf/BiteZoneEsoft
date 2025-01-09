import 'dart:convert';
import 'package:bite_zone/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '70ecba2434024d18a42ed82be8d34208';
  final String baseUrl = 'https://newsapi.org/v2';


  Future<List<NewsArticle>> fetchNews({String type = 'food+sri+lanka'}) async {
    http.Response response;

    response = await http.get(
      Uri.parse('$baseUrl/everything?q=$type&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articles = data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
