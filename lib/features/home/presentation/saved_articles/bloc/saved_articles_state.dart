import 'package:news_app/features/home/domain/entities/article.dart';

abstract class SavedArticlesState {
  final List<ArticleEntity>? articles;
  final Exception? error;

  const SavedArticlesState({this.articles, this.error});
}

class ArticlesLoading extends SavedArticlesState {
  const ArticlesLoading();
}

class ArticlesSuccess extends SavedArticlesState {
  const ArticlesSuccess({super.articles});
}

class ArticlesEmpty extends SavedArticlesState {
  const ArticlesEmpty();
}

class ArticlesError extends SavedArticlesState {
  const ArticlesError({super.error});
}
