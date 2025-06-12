# COMMA (콤마)

일상 속 작은 쉼표, COMMA 앱입니다.

## 프로젝트 구조

```
lib/
├── core/                    # 앱 전반에 걸쳐 사용되는 공통 기능
│   ├── config/             # 환경 설정
│   ├── constants/          # 상수
│   ├── router/             # 라우팅
│   ├── theme/              # 테마
│   └── utils/              # 유틸리티 함수
│
├── data/                    # 데이터 레이어
│   ├── api/                # API 클라이언트
│   ├── repositories/       # 레포지토리 구현체
│   ├── database/          # 로컬 데이터베이스
│   └── services/          # 외부 서비스
│
├── domain/                  # 도메인 레이어
│   ├── entities/           # 비즈니스 엔티티
│   ├── repositories/       # 레포지토리 인터페이스
│   └── usecases/          # 유스케이스
│
├── presentation/           # 프레젠테이션 레이어
│   ├── features/          # 기능별 모듈
│   │   ├── auth/         # 인증 관련
│   │   ├── mission/      # 미션 관련
│   │   ├── reward/       # 리워드 관련
│   │   ├── community/    # 커뮤니티 관련
│   │   └── profile/      # 프로필 관련
│   ├── providers/        # 상태 관리
│   └── shared/          # 공유 위젯
│
└── main.dart
```

## 기술 스택

- Flutter
- Riverpod (상태 관리)
- GoRouter (라우팅)
- SQLite (로컬 데이터베이스)
- Freezed (코드 생성)
- Kakao SDK (소셜 로그인)

## 시작하기

### 필수 조건

- Flutter SDK (최신 버전)
- Dart SDK (최신 버전)
- Android Studio 또는 VS Code
- iOS 개발을 위한 Xcode (Mac 전용)

### 환경 설정

1. 프로젝트 클론
```bash
git clone https://github.com/your-username/comma.git
cd comma
```

2. 의존성 설치
```bash
flutter pub get
```

3. 환경 변수 설정
- `lib/core/config/env.example.dart` 파일을 `env.dart`로 복사:
```bash
cp lib/core/config/env.example.dart lib/core/config/env.dart
```
- `env.dart` 파일에서 다음 값들을 실제 값으로 수정:
  * `kakaoRestApiKey`: 카카오 개발자 콘솔에서 발급받은 REST API 키
  * `redirectUri`: 카카오 로그인 Redirect URI
  * `apiBaseUrl`: 백엔드 API 서버 주소
  * 기타 환경 설정 값들

4. 코드 생성
```bash
flutter pub run build_runner build
```

### 실행

```bash
flutter run
```

## 주요 기능

- 카카오 소셜 로그인
- 일일 미션 시스템
- 리워드 시스템
- 커뮤니티
- 프로필 관리

## 개발 가이드

### 새로운 기능 추가

1. `presentation/features` 디렉토리에 새 기능 폴더 생성
2. 다음 구조로 파일 구성:
```
features/new_feature/
├── pages/           # 화면
├── widgets/         # 해당 기능 전용 위젯
├── providers/       # 상태 관리
└── models/          # 뷰 모델
```

### 코드 스타일

- 클린 아키텍처 원칙 준수
- 각 레이어의 책임 분리
- 의존성 주입 사용
- 테스트 가능한 코드 작성

## 보안

- 환경 변수 파일(`env.dart`)은 절대로 Git에 커밋하지 않습니다.
- API 키와 같은 민감한 정보는 항상 환경 변수로 관리합니다.
- 실제 값이 포함된 설정 파일은 팀원들과 안전한 방법으로 공유합니다.

## 라이센스

이 프로젝트는 MIT 라이센스를 따릅니다.
