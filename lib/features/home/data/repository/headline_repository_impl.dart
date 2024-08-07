import 'dart:io';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/home/data/data_sources/remote/headlines_api_service.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class HeadLineRepositoryImpl implements HeadlineRepository {
  final HeadlinesApiService _headlinesApiService;

  const HeadLineRepositoryImpl(this._headlinesApiService);

  @override
  Future<DataState<List<ArticleEntity>>> getLatest(String country) async {
    try {
      List<ArticleEntity> newsList = List.empty(growable: true);
      String? nextPage;
      while (newsList.length < 20) {
        final httpResponse = await _headlinesApiService.getLatest(
            apiKey: newsAPIKey, country: country, nextPage: nextPage);

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          var imageFilteredNews = httpResponse.data.articles!
              .where((item) =>
                  item.urlToImage != null && item.urlToImage!.isNotEmpty)
              .toList();
          newsList.addAll(imageFilteredNews);
          nextPage = httpResponse.data.nextPage;
        } else {
          throw Exception();
        }
      }
      return DataSuccess(newsList);
    } catch (e) {
      return DataFailed(Exception());
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getTopicHeadlines(
      String country, Topic topic) async {
    try {
      final httpResponse = await _headlinesApiService.getTopicHeadlines(
          apikey: newsAPIKey, country: country, category: topic.name);

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
