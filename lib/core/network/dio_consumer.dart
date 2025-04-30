import 'package:dio/dio.dart';
import '../services/logger_service.dart';
import '../services/service_locator.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio _client;

  DioConsumer() : _client = sl<Dio>();

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _client.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  void _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = error.response?.data;

    AppLogger.e('❌ Dio Error: Status Code: $statusCode');
    AppLogger.e('Response: $message');
  }

  @override
  Future put(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _client.put(path, data: body);
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
      rethrow;
    }
  }

  @override
  Future delete(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _client.delete(path, data: body);
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
      rethrow;
    }
  }

  @override
  Future post(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _client.post(path, data: body);
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
      rethrow;
    }
  }
}
