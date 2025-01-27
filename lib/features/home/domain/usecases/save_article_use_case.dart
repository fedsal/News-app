import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class SaveArticleUseCase extends UseCase<void, ArticleEntity> {
  final HeadlineRepository _headlineRepository;

  SaveArticleUseCase(this._headlineRepository);

  @override
  Future<void> call({required ArticleEntity params}) =>
      _headlineRepository.saveArticle(params);
}
