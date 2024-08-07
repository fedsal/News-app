import 'package:equatable/equatable.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/domain/entities/article.dart';

abstract class HeadlinesState extends Equatable {
  final List<ArticleEntity>? articles;
  final Exception? error;

  const HeadlinesState({this.articles, this.error});

  @override
  List<Object?> get props => [articles, error];
}

class HeadlinesLoading extends HeadlinesState {
  const HeadlinesLoading();
}

class HeadlinesSuccess extends HeadlinesState {
  const HeadlinesSuccess(List<ArticleEntity> articles)
      : super(articles: articles);
}

class TopicHeadlinesSuccess extends HeadlinesState {
  final Topic topic;
  const TopicHeadlinesSuccess(List<ArticleEntity> articles, this.topic)
      : super(articles: articles);
}

class HeadlinesError extends HeadlinesState {
  const HeadlinesError(Exception error) : super(error: error);
}
