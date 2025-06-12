/// 이 파일은 환경 변수 설정을 위한 템플릿입니다.
/// 1. 이 파일을 'env.dart'로 복사합니다.
/// 2. 아래의 값들을 실제 값으로 교체합니다.
/// 3. env.dart 파일은 .gitignore에 포함되어 있으므로 Git에 커밋되지 않습니다.

class Env {
  // Kakao OAuth
  static const String kakaoRestApiKey = 'YOUR_KAKAO_REST_API_KEY';
  static const String redirectUri = 'YOUR_REDIRECT_URI';
  
  // API
  static const String apiBaseUrl = 'YOUR_API_BASE_URL';
  
  // 기타 환경 변수들
  static const bool isDevelopment = true;
  static const String appName = 'COMMA';
  
  static Future<void> initialize() async {
    // 초기화가 필요한 경우 여기에 로직을 추가합니다.
    // 예: Firebase 초기화, 디바이스 정보 로드 등
  }
  
  // 환경별 설정
  static Map<String, dynamic> get config {
    if (isDevelopment) {
      return {
        'apiUrl': '$apiBaseUrl/dev',
        'logLevel': 'debug',
      };
    } else {
      return {
        'apiUrl': '$apiBaseUrl/prod',
        'logLevel': 'error',
      };
    }
  }
} 