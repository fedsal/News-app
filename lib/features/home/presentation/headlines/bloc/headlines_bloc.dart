import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/home/domain/usecases/get_country_headlines.dart';
import 'package:news_app/features/home/domain/usecases/get_topic_headlines_use_case.dart';
import 'package:news_app/features/home/domain/usecases/search_news_use_case.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_event.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  final GetCountryHeadlinesUseCase _getCountryHeadlinesUseCase;
  final GetTopicHeadlinesUseCase _getTopicHeadlinesUseCase;
  final SearchNewsUseCase _searchNewsUseCase;

  HeadlinesBloc(this._getCountryHeadlinesUseCase,
      this._getTopicHeadlinesUseCase, this._searchNewsUseCase)
      : super(const HeadlinesLoading()) {
    on<GetHeadlines>(onGetHeadlines);
    on<GetTopicHeadlines>(onGetTopicHeadlines);
    on<SearchNews>(onSearchNews);

    add(const GetHeadlines());
  }

  void onGetHeadlines(GetHeadlines event, Emitter<HeadlinesState> emit) async {
    final dataState = await _getCountryHeadlinesUseCase(params: 'ar');

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(HeadlinesSuccess(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(HeadlinesError(dataState.error!));
    }
  }

  void onGetTopicHeadlines(
      GetTopicHeadlines event, Emitter<HeadlinesState> emit) async {
    emit(const HeadlinesLoading());
    final dataState = await _getTopicHeadlinesUseCase(
        params:
            GetTopicHeadlinesUseCaseParams(country: 'ar', topic: event.topic));

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(TopicHeadlinesSuccess(dataState.data!, event.topic));
    } else if (dataState is DataFailed) {
      emit(HeadlinesError(dataState.error!));
    }
  }

  void onSearchNews(SearchNews event, Emitter<HeadlinesState> emit) async {
    if (event.query.isEmpty) {
      // TODO: show toast
      return;
    }
    emit(const HeadlinesLoading());
    final dataState = await _searchNewsUseCase(
        params: SearchNewsUseCaseParams(country: 'ar', query: event.query));
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(SearchNewsSuccess(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(HeadlinesError(dataState.error!));
    }
  }
}
