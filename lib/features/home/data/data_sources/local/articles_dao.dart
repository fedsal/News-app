import 'package:floor/floor.dart';
import 'package:news_app/features/home/data/models/article.dart';

@dao
abstract class ArticlesDao {
  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query('SELECT * FROM articles')
  Future<List<ArticleModel>> getSavedArticles();
}
