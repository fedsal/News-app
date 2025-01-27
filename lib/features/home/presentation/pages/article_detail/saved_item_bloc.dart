import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/domain/usecases/delete_saved_article_use_case.dart';
import 'package:news_app/features/home/domain/usecases/get_saved_news_use_case.dart';
import 'package:news_app/features/home/domain/usecases/save_article_use_case.dart';

// MARK: State section

sealed class SavedArticleState {
  final ArticleEntity article;

  const SavedArticleState(this.article);
}

class CheckingSavedStatus extends SavedArticleState {
  CheckingSavedStatus(super.article);
}

class ArticleSaved extends SavedArticleState {
  ArticleSaved(super.article);
}

class ArticleNotSaved extends SavedArticleState {
  ArticleNotSaved(super.article);
}

// MARK: Event Section

abstract class SaveArticleEvent {
  final ArticleEntity article;
  const SaveArticleEvent(this.article);
}

class ToggleSavedArticle extends SaveArticleEvent {
  const ToggleSavedArticle(super.article);
}

class PersistInStateHolder extends SaveArticleEvent {
  const PersistInStateHolder(super.article);
}

class CheckSavedStatus extends SaveArticleEvent {
  const CheckSavedStatus(super.article);
}

// MARK: Bloc Section

class SavedItemBloc extends Bloc<SaveArticleEvent, SavedArticleState> {
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteSavedArticleUseCase _deleteSavedArticleUseCase;
  final GetSavedNewsUseCase _getSavedNewsUseCase;

  SavedItemBloc(this._getSavedNewsUseCase, this._saveArticleUseCase,
      this._deleteSavedArticleUseCase)
      : super(ArticleNotSaved(const ArticleEntity())) {
    on<ToggleSavedArticle>(onToggleSavedArticle);
    on<CheckSavedStatus>(onCheckSavedStatus);
    on<PersistInStateHolder>(onPersistInStateHolder);
  }

  void onPersistInStateHolder(
      PersistInStateHolder event, Emitter<SavedArticleState> emit) {
    emit(CheckingSavedStatus(event.article));
    add(CheckSavedStatus(event.article));
  }

  void onToggleSavedArticle(
      ToggleSavedArticle event, Emitter<SavedArticleState> emit) async {
    try {
      if (state is ArticleSaved) {
        _deleteSavedArticleUseCase.call(params: event.article);
        emit(ArticleNotSaved(event.article));
      } else {
        _saveArticleUseCase.call(params: event.article);
        emit(ArticleSaved(event.article));
      }
    } catch (e) {
      // TODO: do nothing yet
    }
  }

  void onCheckSavedStatus(
      CheckSavedStatus event, Emitter<SavedArticleState> emit) async {
    final dataState = await _getSavedNewsUseCase.call(params: null);

    if (dataState is DataSuccess && dataState.data!.contains(event.article)) {
      emit(ArticleSaved(state.article));
    } else {
      emit(ArticleNotSaved(state.article));
    }
  }
}
