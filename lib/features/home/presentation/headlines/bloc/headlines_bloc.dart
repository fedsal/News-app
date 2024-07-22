import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/home/domain/usecases/get_country_headlines.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_event.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  final GetCountryHeadlinesUseCase _getCountryHeadlinesUseCase;

  HeadlinesBloc(this._getCountryHeadlinesUseCase)
      : super(const HeadlinesLoading()) {
    on<GetHeadlines>(onGetHeadlines);

    add(GetHeadlines());
  }

  void onGetHeadlines(GetHeadlines event, Emitter<HeadlinesState> emit) async {
    final dataState = await _getCountryHeadlinesUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(HeadlinesSuccess(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(HeadlinesError(dataState.error!));
    }
  }
}
