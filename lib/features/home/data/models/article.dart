import 'package:news_app/features/home/data/models/source.dart';
import 'package:news_app/features/home/domain/entities/article.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.source,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) => ArticleModel(
      source: SourceModel.fromJson(map['source'] ?? ""),
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '');

  factory ArticleModel.fromEntity(ArticleEntity entity) => ArticleModel(
        source: entity.source,
        author: entity.author,
        title: entity.title,
        description: entity.description,
        url: entity.url,
        urlToImage: entity.urlToImage,
        publishedAt: entity.publishedAt,
        content: entity.content,
      );
}
