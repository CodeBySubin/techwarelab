import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:techware/core/network/api_endpoint.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio _dio;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: APIConfig.baseURL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {

        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("[API REQUEST] ${options.method} → ${options.uri}");
          if (options.data != null) debugPrint("[BODY] ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
              "[API RESPONSE] ${response.statusCode} → ${response.requestOptions.uri}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint("[API ERROR] ${e.message}");
          if (e.response != null) {
            debugPrint(
                "[ERROR DETAILS] ${e.response?.statusCode} → ${e.response?.data}");
          }
          return handler.next(e);
        },
      ),
    );
  }

  factory ApiClient() => _instance;

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    return await _dio.get(endpoint, queryParameters: params);
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    return await _dio.post(endpoint, data: data);
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
    return await _dio.put(endpoint, data: data);
  }

  Future<Response> delete(String endpoint, {dynamic data}) async {
    return await _dio.delete(endpoint, data: data);
  }
}
