import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'http_client.dart';

class DioHttpClient implements HttpClient {
  final Dio _dio;

  DioHttpClient(this._dio) {
    _initInterceptor();
  }

  @override
  Future<Response> get(String url,
      {Map<String, dynamic>? params, Map<String, dynamic>? headers}) async {
    try {
      return await _dio.get(url,
          queryParameters: params, options: Options(headers: headers));
    } on DioException catch (e) {
      return _onDioError(e);
    }
  }

  @override
  Future<Response> post(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    try {
      return await _dio.post(url,
          data: body, options: Options(headers: headers));
    } on DioException catch (e) {
      return _onDioError(e);
    }
  }

  Response _onDioError(DioException error) {
    String errorMessage;
    if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'Connection timeout. Please try again.';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Receive timeout. Please try again.';
    } else if (error.type == DioExceptionType.unknown) {
      errorMessage = 'Network error. Please check your internet connection.';
    } else {
      errorMessage = 'Unexpected error occurred: ${error.message}';
    }
    return Response(
      requestOptions: error.requestOptions,
      statusMessage: errorMessage,
    );
  }

  void _initInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          if (kDebugMode) {
            log('Request: ${options.method} ${options.path}');
          }

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          if (kDebugMode) {
            log('Response: ${response.statusCode} ${response.data}');
          }

          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          if (kDebugMode) {
            log('-----ApiError[${error.response?.statusCode}]-----');
            log('=====> Endpoint: ${error.response?.requestOptions.path} <=====');
            log('ErrorResponse: ${error.response?.data}');
          }

          return handler.next(error);
        },
      ),
    );
  }
}
