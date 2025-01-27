import 'package:news_app/features/home/data/models/article.dart';

class ArticleResponse {
  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;
  final String? nextPage;

  const ArticleResponse(
      {this.status, this.totalResults, this.articles, this.nextPage});

  factory ArticleResponse.fromJson(Map<String, dynamic> map) {
    List<dynamic> articlesList = map['results'];
    List<ArticleModel> parsedArticles =
        articlesList.map((article) => ArticleModel.fromJson(article)).toList();
    return ArticleResponse(
        status: map['author'] ?? '',
        totalResults: map['totalResults'] ?? '',
        articles: parsedArticles,
        nextPage: map['nextPage'] ?? '');
  }
}
