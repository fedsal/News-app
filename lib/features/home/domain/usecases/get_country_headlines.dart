import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class GetCountryHeadlinesUseCase
    implements UseCase<DataState<List<ArticleEntity>>, String> {
  final HeadlineRepository _headlineRepository;

  GetCountryHeadlinesUseCase(this._headlineRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({String params = 'bbc-news'}) =>
      _headlineRepository.getHeadLines(params);
}
