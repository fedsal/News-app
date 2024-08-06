import 'package:dio/dio.dart';
import 'package:news_app/features/home/data/models/article_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

part 'headlines_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class HeadlinesApiService {
  factory HeadlinesApiService(Dio dio) = _HeadlinesApiService;

  @GET("/top-headlines")
  Future<HttpResponse<ArticleResponse>> getHeadlines({
    @Query("apiKey") String? apiKey,
    @Query("sources") String? sources,
  });

  @GET("/top-headlines")
  Future<HttpResponse<ArticleResponse>> getTopicHeadlines(
      {@Query("apiKey") String? apikey, @Query("category") String? category});
}
