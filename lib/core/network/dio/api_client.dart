import 'package:dio/dio.dart';
import 'package:event_booking/core/errors/exceptions.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Exception _mapDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkException('Connection timed out. Please try again.');

      case DioExceptionType.connectionError:
        return NetworkException(
          'No internet connection. Please check your network.',
        );

      case DioExceptionType.badCertificate:
        return ServerException('Secure connection failed.');

      case DioExceptionType.cancel:
        return ServerException('Request was cancelled.');

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode ?? 0;

        switch (statusCode) {
          case 400:
            return ServerException('Invalid Request');

          case 401:
            return ServerException(
              'Your session has expired. Please login again.',
            );

          case 403:
            return ServerException(
              'You are not allowed to perform this action.',
            );

          case 404:
            return ServerException('Requested resource was not found.');

          case 500:
          case 502:
          case 503:
            return ServerException(
              'Something went wrong on our side. Please try again later.',
            );

          default:
            return ServerException('Something went wrong. Please try again.');
        }

      default:
        return ServerException(
          'There is some error at server side. Please try again later.',
        );
    }
  }
}

class LoggingInterceptor implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      "=========================================================================",
    );
    debugPrint('❌ ERROR');
    debugPrint('🌐 URL: ${err.requestOptions.uri}');
    debugPrint('📌 METHOD: ${err.requestOptions.method}');
    debugPrint('🔢 STATUS CODE: ${err.response?.statusCode}');
    debugPrint('⚠️ MESSAGE: ${err.message}');
    debugPrint('📥 ERROR RESPONSE: ${err.response?.data}');
    debugPrint(
      "=========================================================================",
    );

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
      "=========================================================================",
    );
    debugPrint('🚀 REQUEST');
    debugPrint('🌐 URL: ${options.uri}');
    debugPrint('📌 METHOD: ${options.method}');
    debugPrint('📤 HEADERS: ${options.headers}');
    debugPrint('📦 REQUEST DATA: ${options.data}');
    debugPrint('❓ QUERY PARAMS: ${options.queryParameters}');
    debugPrint(
      "=========================================================================",
    );

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
      "=========================================================================",
    );
    debugPrint('✅ RESPONSE');
    debugPrint('🌐 URL: ${response.requestOptions.uri}');
    debugPrint('📌 METHOD: ${response.requestOptions.method}');
    debugPrint('🔢 STATUS CODE: ${response.statusCode}');
    debugPrint('📥 RESPONSE DATA: ${response.data}');
    debugPrint(
      "=========================================================================",
    );

    handler.next(response);
  }
}
