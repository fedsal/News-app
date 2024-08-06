import 'dart:io';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/home/data/data_sources/remote/headlines_api_service.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class HeadLineRepositoryImpl implements HeadlineRepository {
  final HeadlinesApiService _headlinesApiService;
  final apiKey = "bf4d1f8d1556497892f3b75deb89fef1";

  const HeadLineRepositoryImpl(this._headlinesApiService);

  @override
  Future<DataState<List<ArticleEntity>>> getHeadLines(String sources) async {
    try {
      final httpResponse = await _headlinesApiService.getHeadlines(
          apiKey: apiKey, sources: sources);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles!);
      } else {
        return DataFailed(Exception());
      }
    } catch (e) {
      return DataFailed(Exception());
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getTopicHeadlines(Topic topic) async {
    try {
      final httpResponse = await _headlinesApiService.getTopicHeadlines(
          apikey: apiKey, category: topic.name);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles!);
      } else {
        return DataFailed(Exception());
      }
    } catch (e) {
      return DataFailed(Exception());
    }
  }
}
