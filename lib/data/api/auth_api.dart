import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/entities/auth_response.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "https://api.comma.com")
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST("/signIn_kakao")
  Future<AuthResponse> signInWithKakao({
    @Body() required Map<String, dynamic> body,
  });
} 