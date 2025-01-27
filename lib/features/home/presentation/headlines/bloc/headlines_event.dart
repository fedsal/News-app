import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/data/models/countries.dart';

abstract class HeadlinesEvent {
  const HeadlinesEvent();
}

class GetHeadlines extends HeadlinesEvent {
  const GetHeadlines();
}

class GetTopicHeadlines extends HeadlinesEvent {
  final Topic topic;
  const GetTopicHeadlines({required this.topic});
}

class SelectCountry extends HeadlinesEvent {
  final Country country;
  const SelectCountry({required this.country});
}

class SearchNews extends HeadlinesEvent {
  final String query;
  const SearchNews({required this.query});
}
