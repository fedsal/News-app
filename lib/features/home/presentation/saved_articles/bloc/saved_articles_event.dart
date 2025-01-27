import 'package:news_app/features/home/domain/entities/article.dart';

abstract class SavedArticlesEvent {
  const SavedArticlesEvent();
}

class FetchArticles extends SavedArticlesEvent {
  const FetchArticles();
}

class RemoveArticle extends SavedArticlesEvent {
  final ArticleEntity article;
  const RemoveArticle({required this.article});
}
