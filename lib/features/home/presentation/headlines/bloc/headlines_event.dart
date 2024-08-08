import 'package:news_app/features/home/data/models/categories.dart';

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

class SearchNews extends HeadlinesEvent {
  final String query;
  const SearchNews({required this.query});
}
