import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class GetTopicHeadlinesUseCase extends UseCase<DataState<List<ArticleEntity>>,
    GetTopicHeadlinesUseCaseParams> {
  final HeadlineRepository _headlineRepository;

  GetTopicHeadlinesUseCase(this._headlineRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call(
          {required GetTopicHeadlinesUseCaseParams params}) =>
      _headlineRepository.getTopicHeadlines(params.country, params.topic);
}

class GetTopicHeadlinesUseCaseParams {
  final String country;
  final Topic topic;

  GetTopicHeadlinesUseCaseParams({required this.country, required this.topic});
}
