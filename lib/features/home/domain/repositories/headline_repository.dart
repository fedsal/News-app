import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/domain/entities/article.dart';

abstract class HeadlineRepository {
  Future<DataState<List<ArticleEntity>>> getHeadLines(String sources);

  Future<DataState<List<ArticleEntity>>> getTopicHeadlines(Topic topic);
}
