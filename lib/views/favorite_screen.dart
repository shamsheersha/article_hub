import 'package:article_hub/views/article_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:article_hub/controllers/article_controller.dart';
import 'package:article_hub/views/widgets/article_card.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(articleControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Articles'),
      ),
      body: articleState.when(
        data: (articles) {
          // Filter favorite articles
          final favorites =
              articles.where((article) => article.isFavorite).toList();

          if (favorites.isEmpty) {
            return const Center(
              child: Text('No favorite articles yet.'),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final article = favorites[index];
              return ArticleCard(
                article: article,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailScreen(article: article),
                    ),
                  );
                },
              );
            },
          );
        },
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
