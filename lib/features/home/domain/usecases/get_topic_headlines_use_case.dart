import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/repositories/headline_repository.dart';

class GetTopicHeadlinesUseCase
    extends UseCase<DataState<List<ArticleEntity>>, Topic> {
  final HeadlineRepository _headlineRepository;

  GetTopicHeadlinesUseCase(this._headlineRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({Topic params = Topic.general}) =>
      _headlineRepository.getTopicHeadlines(params);
}
