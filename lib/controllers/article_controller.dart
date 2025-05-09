import 'dart:developer';

import 'package:article_hub/models/article_model.dart';
import 'package:article_hub/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

final articleControllerProvider =
    StateNotifierProvider<ArticleController, AsyncValue<List<ArticleModel>>>(
        (_) => ArticleController());

class ArticleController extends StateNotifier<AsyncValue<List<ArticleModel>>> {
  ArticleController() : super(const AsyncValue.loading()) {
    fetchArticles();
  }

  final ApiService _apiService = ApiService();
  final Box<ArticleModel> _favoriteBox =
      Hive.box<ArticleModel>('favoriteArticles');

  fetchArticles() async {
    state = const AsyncValue.loading();

    try {
      final articles = await _apiService.fetchArticles();
      
      final favoriteIds = _favoriteBox.keys.cast<int>().toList();
      for(var article in articles) {
        article.isFavorite = favoriteIds.contains(article.id);
      }

      state = AsyncValue.data(articles);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

searchArticles(String query) async {
  state = const AsyncValue.loading();

  try {
    final articles = await _apiService.fetchArticles();
    final favoriteIds = _favoriteBox.keys.map((key) => key as int).toList();

    // Update the isFavorite property for all articles
    final updatedArticles = articles.map((article) {
      article.isFavorite = favoriteIds.contains(article.id);
      return article;
    }).toList();

    // Filter articles based on the search query
    final List<ArticleModel> filteredArticles = updatedArticles
        .where((dynamic article) => 
            (article as ArticleModel).title.toLowerCase().contains(query.toLowerCase()))
        .cast<ArticleModel>()
        .toList();

    state = AsyncValue.data(filteredArticles);
  } catch (e) {
    log(e.toString());
    state = AsyncValue.error(e, StackTrace.current);
  }
}


  toggleFavorite(ArticleModel article) {
    final index = state.value?.indexWhere((a) => a.id == article.id);
    if (index != null && index != -1) {
      final updatedArticle = ArticleModel(
          id: article.id,
          title: article.title,
          body: article.body,
          isFavorite: !article.isFavorite);
      if (updatedArticle.isFavorite) {
        _favoriteBox.put(article.id, updatedArticle);
      } else {
        _favoriteBox.delete(article.id);
      }

      final updatedAtricles = List<ArticleModel>.from(state.value!);
      updatedAtricles[index] = updatedArticle;
      state = AsyncValue.data(updatedAtricles);
    }
  }

  List<ArticleModel> get getFavorites {
    return _favoriteBox.values.toList();
  }
}
