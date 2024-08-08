import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class DeleteSavedArticleUseCase extends UseCase<void, ArticleEntity> {
  final HeadlineRepository _headlineRepository;

  DeleteSavedArticleUseCase(this._headlineRepository);

  @override
  Future<void> call({required ArticleEntity params}) =>
      _headlineRepository.deleteArticle(params);
}
