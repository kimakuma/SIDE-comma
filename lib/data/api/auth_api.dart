import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/auth_response.dart';
import '../../core/config/env.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: Env.apiBaseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST("/signIn_kakao")
  Future<AuthResponse> signInWithKakao({
    @Body() required Map<String, dynamic> body,
  });
} 