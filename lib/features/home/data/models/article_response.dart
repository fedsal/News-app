import 'package:news_app/features/home/data/models/article.dart';

class ArticleResponse {
  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;

  const ArticleResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> map) {
    List<dynamic> articlesList = map['articles'];
    List<ArticleModel> parsedArticles =
        articlesList.map((article) => ArticleModel.fromJson(article)).toList();
    return ArticleResponse(
        status: map['author'] ?? '',
        totalResults: map['totalResults'] ?? '',
        articles: parsedArticles);
  }
}
