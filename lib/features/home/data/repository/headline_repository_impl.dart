import 'dart:io';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/home/data/data_sources/local/app_database.dart';
import 'package:news_app/features/home/data/data_sources/remote/headlines_api_service.dart';
import 'package:news_app/features/home/data/models/article.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class HeadLineRepositoryImpl implements HeadlineRepository {
  final HeadlinesApiService _headlinesApiService;
  final AppDatabase _appDatabase;

  const HeadLineRepositoryImpl(this._headlinesApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleEntity>>> getLatest(String country) async {
    try {
      final news = await _filterNullImageNews(country: country);
      return DataSuccess(news);
    } catch (e) {
      return DataFailed(Exception());
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getTopicHeadlines(
      String country, Topic topic) async {
    try {
      final news =
          await _filterNullImageNews(country: country, category: topic.name);
      return DataSuccess(news);
    } catch (e) {
      return DataFailed(Exception());
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> searchNews(
      String country, String query) async {
    try {
      final news = await _filterNullImageNews(country: country, query: query);
      return DataSuccess(news);
    } catch (e) {
      return DataFailed(Exception());
    }
  }

  Future<List<ArticleEntity>> _filterNullImageNews(
      {String? country, String? category, String? query}) async {
    List<ArticleEntity> newsList = List.empty(growable: true);
    String? nextPage;
    while (newsList.length < 20) {
      final httpResponse = await _headlinesApiService.getLatest(
          apiKey: newsAPIKey,
          country: country,
          category: category,
          query: query,
          nextPage: nextPage);

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
    return newsList;
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) async {
    _appDatabase.articlesDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<DataState<List<ArticleEntity>>> getSavedNews() async {
    var news = await _appDatabase.articlesDao.getSavedArticles();
    return DataSuccess(news);
  }

  @override
  Future<void> saveArticle(ArticleEntity article) async {
    _appDatabase.articlesDao.insertArticle(ArticleModel.fromEntity(article));
  }
}
