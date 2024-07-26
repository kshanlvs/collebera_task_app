import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'dio_http_client.dart';
import 'http_client.dart';

class HttpClientFactory {
  static HttpClient createHttpClient() {
    final dio = DioForNative();
    const String apiUrl = "https://fakestoreapi.com";
    dio.options = BaseOptions(baseUrl: apiUrl);
    return DioHttpClient(dio);
  }
}
