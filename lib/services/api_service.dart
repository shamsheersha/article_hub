import 'dart:convert';
import 'package:article_hub/models/article_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if(response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ArticleModel.fromJson(json)).toList();
      }
    }catch(e){
      throw Exception('Failed to load articles: $e');
    }
  }
}