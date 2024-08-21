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
      : super(const HeadlinesState(isLoading: true)) {
    on<GetHeadlines>(onGetHeadlines);
    on<GetTopicHeadlines>(onGetTopicHeadlines);
    on<SearchNews>(onSearchNews);
    on<SelectCountry>(onSelectCountry);

    add(const GetHeadlines());
  }

  onSelectCountry(SelectCountry event, Emitter<HeadlinesState> emit) {
    emit(state.copyWith(country: event.country));
  }

  void onGetHeadlines(GetHeadlines event, Emitter<HeadlinesState> emit) async {
    emit(state.copyWith(isLoading: true));
    final dataState =
        await _getCountryHeadlinesUseCase(params: state.country.code);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(state.copyWith(
          isLoading: false,
          articles: dataState.data!,
          topic: null,
          error: null));
    } else if (dataState is DataFailed) {
      emit(state.copyWith(isLoading: false, error: dataState.error!));
    }
  }

  void onGetTopicHeadlines(
      GetTopicHeadlines event, Emitter<HeadlinesState> emit) async {
    emit(state.copyWith(isLoading: true));
    final dataState = await _getTopicHeadlinesUseCase(
        params: GetTopicHeadlinesUseCaseParams(
            country: state.country.code, topic: event.topic));

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(state.copyWith(
          isLoading: false,
          articles: dataState.data!,
          topic: event.topic,
          error: null));
    } else if (dataState is DataFailed) {
      emit(state.copyWith(isLoading: false, error: dataState.error!));
    }
  }

  void onSearchNews(SearchNews event, Emitter<HeadlinesState> emit) async {
    if (event.query.isEmpty) {
      // TODO: show toast
      return;
    }
    emit(state.copyWith(isLoading: true, topic: null));
    final dataState = await _searchNewsUseCase(
        params: SearchNewsUseCaseParams(
            country: state.country.code, query: event.query));
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(state.copyWith(
          isLoading: false, articles: dataState.data!, error: null));
    } else if (dataState is DataFailed) {
      emit(state.copyWith(isLoading: false, error: dataState.error!));
    }
  }
}
