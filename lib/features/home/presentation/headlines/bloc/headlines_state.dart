import 'package:equatable/equatable.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/data/models/countries.dart';
import 'package:news_app/features/home/domain/entities/article.dart';

class HeadlinesState extends Equatable {
  final List<ArticleEntity> articles;
  final Exception? error;
  final Country country;
  final bool isLoading;
  final Topic? topic;

  const HeadlinesState(
      {this.isLoading = false,
      this.country = Country.unitedStatesOfAmerica,
      this.articles = const [],
      this.topic,
      this.error});

  HeadlinesState copyWith(
      {bool? isLoading,
      Country? country,
      List<ArticleEntity>? articles,
      Topic? topic,
      Exception? error}) {
    return HeadlinesState(
        isLoading: isLoading ?? this.isLoading,
        country: country ?? this.country,
        articles: articles ?? this.articles,
        topic: topic,
        error: error);
  }

  @override
  List<Object?> get props => [isLoading, country, articles, topic, error];
}
