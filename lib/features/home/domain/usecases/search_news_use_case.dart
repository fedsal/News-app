import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class SearchNewsUseCase
    extends UseCase<DataState<List<ArticleEntity>>, SearchNewsUseCaseParams> {
  final HeadlineRepository _headlineRepository;

  SearchNewsUseCase(this._headlineRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call(
          {required SearchNewsUseCaseParams params}) =>
      _headlineRepository.searchNews(params.country, params.query);
}

class SearchNewsUseCaseParams {
  final String country;
  final String query;

  const SearchNewsUseCaseParams({required this.country, required this.query});
}
