import 'package:dio/dio.dart';
import 'package:news_app/features/home/data/models/article_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

part 'headlines_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class HeadlinesApiService {
  factory HeadlinesApiService(Dio dio) = _HeadlinesApiService;

  @GET("/latest")
  Future<HttpResponse<ArticleResponse>> getLatest({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("page") String? nextPage,
    @Query("category") String? category,
    @Query("qInTitle") String? query,
  });
}
