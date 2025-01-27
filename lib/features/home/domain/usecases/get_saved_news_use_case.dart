import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class GetSavedNewsUseCase
    extends UseCase<DataState<List<ArticleEntity>>, void> {
  final HeadlineRepository _headlineRepository;

  GetSavedNewsUseCase(this._headlineRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({required params}) =>
      _headlineRepository.getSavedNews();
}
