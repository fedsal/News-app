import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? articleId;
  final String? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity({
    this.articleId,
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props => [
        articleId,
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
