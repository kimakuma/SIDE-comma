import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get kakaoRestApiKey {
    final key = dotenv.env['KAKAO_REST_API_KEY'];
    if (key == null) throw Exception('KAKAO_REST_API_KEY not found in .env file');
    return key;
  }

  static String get apiBaseUrl {
    final url = dotenv.env['API_BASE_URL'];
    if (url == null) throw Exception('API_BASE_URL not found in .env file');
    return url;
  }

  static String get redirectUri => '$apiBaseUrl';

  static Future<void> initialize() async {
    await dotenv.load();
  }
} 