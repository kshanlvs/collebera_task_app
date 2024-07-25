import 'package:dio/dio.dart';

abstract class HttpClient {
  Future<Response> get(String url, {Map<String, dynamic>? params, Map<String,dynamic> headers});
  Future<Response> post(String url, {Map<String, dynamic>? body,Map<String,dynamic> headers});
  // Future<Response> put(String url, {Map<String, dynamic>? body});  
  // Future<Response> delete(String url, {Map<String, dynamic>? params});
  
}