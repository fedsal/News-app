import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/data/data_sources/local/app_database.dart';
import 'package:news_app/features/home/data/data_sources/remote/headlines_api_service.dart';
import 'package:news_app/features/home/data/repository/headline_repository_impl.dart';
import 'package:news_app/features/home/domain/usecases/delete_saved_article_use_case.dart';
import 'package:news_app/features/home/domain/usecases/get_country_headlines.dart';
import 'package:news_app/features/home/domain/usecases/get_saved_news_use_case.dart';
import 'package:news_app/features/home/domain/usecases/get_topic_headlines_use_case.dart';
import 'package:news_app/features/home/domain/usecases/save_article_use_case.dart';
import 'package:news_app/features/home/domain/usecases/search_news_use_case.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_bloc.dart';
import 'package:news_app/features/home/presentation/pages/article_detail/saved_item_bloc.dart';
import 'package:news_app/features/home/presentation/pages/home_page.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MyApp(appDatabase: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase appDatabase;
  const MyApp({super.key, required this.appDatabase});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var repository =
        HeadLineRepositoryImpl(HeadlinesApiService(Dio()), appDatabase);
    var getSavedNewsUseCase = GetSavedNewsUseCase(repository);
    var deleteSavedArticleUseCase = DeleteSavedArticleUseCase(repository);
    return MultiBlocProvider(
        providers: [
          BlocProvider<HeadlinesBloc>(
              create: (BuildContext context) => HeadlinesBloc(
                  GetCountryHeadlinesUseCase(repository),
                  GetTopicHeadlinesUseCase(repository),
                  SearchNewsUseCase(repository))),
          BlocProvider(
              create: (BuildContext context) => SavedArticlesBloc(
                  getSavedNewsUseCase, deleteSavedArticleUseCase)),
          BlocProvider(
              create: (BuildContext context) => SavedItemBloc(
                  getSavedNewsUseCase,
                  SaveArticleUseCase(repository),
                  deleteSavedArticleUseCase))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: 'Gellix'),
          home: const HomePage(),
        ));
  }
}
