import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_api.dart';

part 'api_client.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));
  return dio;
}

@riverpod
AuthApi authApi(AuthApiRef ref) {
  return AuthApi(ref.watch(dioProvider));
} 