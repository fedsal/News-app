import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/data/data_sources/remote/headlines_api_service.dart';
import 'package:news_app/features/home/data/repository/headline_repository_impl.dart';
import 'package:news_app/features/home/domain/usecases/get_country_headlines.dart';
import 'package:news_app/features/home/domain/usecases/get_topic_headlines_use_case.dart';
import 'package:news_app/features/home/domain/usecases/search_news_use_case.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_bloc.dart';
import 'package:news_app/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Gellix'),
      home: BlocProvider(
        create: (BuildContext context) {
          var repository = HeadLineRepositoryImpl(HeadlinesApiService(Dio()));
          return HeadlinesBloc(
              GetCountryHeadlinesUseCase(repository),
              GetTopicHeadlinesUseCase(repository),
              SearchNewsUseCase(repository));
        },
        child: const HomePage(),
      ),
    );
  }
}
