import 'package:floor/floor.dart';
import 'package:news_app/features/home/domain/entities/article.dart';

@Entity(tableName: 'articles', primaryKeys: ['articleId'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.articleId,
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
      articleId: map['article_id'],
      source: map['source_name'],
      author: _parseCreator(map['creator']),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['link'] ?? '',
      urlToImage: map['image_url'] ?? '',
      publishedAt: map['pubDate'] ?? '',
      content: map['content'] ?? '');

  factory ArticleModel.fromEntity(ArticleEntity entity) => ArticleModel(
        articleId: entity.articleId,
        source: entity.source,
        author: entity.author,
        title: entity.title,
        description: entity.description,
        url: entity.url,
        urlToImage: entity.urlToImage,
        publishedAt: entity.publishedAt,
        content: entity.content,
      );

  static String _parseCreator(dynamic creator) {
    if (creator is List) {
      // Join the list items into a single string
      return creator.map((item) => item.toString()).join(', ');
    }
    // Return an empty string if 'creator' is not a list
    return '';
  }
}
