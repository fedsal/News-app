import 'package:floor/floor.dart';
import 'package:news_app/features/home/data/data_sources/local/articles_dao.dart';
import 'package:news_app/features/home/data/models/article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticlesDao get articlesDao;
}
