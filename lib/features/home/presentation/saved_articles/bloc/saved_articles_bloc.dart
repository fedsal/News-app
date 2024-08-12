import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/home/domain/usecases/delete_saved_article_use_case.dart';
import 'package:news_app/features/home/domain/usecases/get_saved_news_use_case.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_state.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_event.dart';

class SavedArticlesBloc extends Bloc<SavedArticlesEvent, SavedArticlesState> {
  final GetSavedNewsUseCase _getSavedNewsUseCase;
  final DeleteSavedArticleUseCase _deleteSavedArticleUseCase;

  SavedArticlesBloc(this._getSavedNewsUseCase, this._deleteSavedArticleUseCase)
      : super(const ArticlesLoading()) {
    on<FetchArticles>(onFetchArticles);
    on<RemoveArticle>(onRemoveArticle);

    add(const FetchArticles());
  }

  Future<void> onFetchArticles(
      FetchArticles event, Emitter<SavedArticlesState> emit) async {
    final dataState = await _getSavedNewsUseCase(params: null);

    if (dataState is DataSuccess) {
      if (dataState.data!.isNotEmpty) {
        emit(ArticlesSuccess(articles: dataState.data!));
      } else {
        emit(const ArticlesEmpty());
      }
    } else if (dataState is DataFailed) {
      emit(ArticlesError(error: dataState.error!));
    }
  }

  void onRemoveArticle(
      RemoveArticle event, Emitter<SavedArticlesState> emit) async {
    await _deleteSavedArticleUseCase(params: event.article);
    add(const FetchArticles());
  }
}
