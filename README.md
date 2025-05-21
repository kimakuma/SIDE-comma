# Comma

Flutter 기반의 모던 앱 프로젝트

## 프로젝트 구조

```
lib/
├── core/                   # 핵심 유틸리티 및 공통 기능
│   ├── constants/         # 상수 정의
│   ├── theme/            # 앱 테마 설정
│   └── utils/            # 유틸리티 함수
├── data/                  # 데이터 계층
│   ├── models/           # 데이터 모델
│   ├── repositories/     # 리포지토리 구현
│   └── services/         # API 서비스
├── domain/               # 비즈니스 로직 계층
│   ├── entities/         # 비즈니스 엔티티
│   ├── repositories/     # 리포지토리 인터페이스
│   └── usecases/        # 유스케이스
├── presentation/         # UI 계층
│   ├── pages/           # 페이지 위젯
│   ├── widgets/         # 재사용 가능한 위젯
│   └── providers/       # 상태 관리
└── main.dart            # 앱 진입점
```

## 기술 스택

- **상태 관리**: Riverpod
- **라우팅**: go_router
- **네트워크**: dio
- **로컬 저장소**: shared_preferences
- **데이터베이스**: sqflite
- **UI 컴포넌트**: material_design_icons_flutter
- **유틸리티**: freezed, json_serializable

## 개발 환경 설정

1. Flutter SDK 설치 (3.19.0 이상)
2. 의존성 설치:
   ```bash
   flutter pub get
   ```
3. 코드 생성:
   ```bash
   flutter pub run build_runner build
   ```

## 코딩 컨벤션

- 파일명: snake_case 사용 (예: user_repository.dart)
- 클래스명: PascalCase 사용 (예: UserRepository)
- 변수/함수명: camelCase 사용 (예: getUserData)
- 상수: SCREAMING_SNAKE_CASE 사용 (예: API_BASE_URL)

## CI/CD

프로젝트는 GitHub Actions를 통한 자동화된 CI/CD 파이프라인을 구현하고 있습니다:

### CI (Continuous Integration)
- 코드 포맷팅 검사
- 정적 분석
- 단위 테스트 실행
- APK 빌드

### CD (Continuous Deployment)
- main 브랜치 푸시 시 자동 배포
- APK 아티팩트 생성
- Firebase App Distribution을 통한 배포 (선택사항)

## 빌드 및 실행

개발 환경에서 실행:
```bash
flutter run
```

릴리즈 빌드:
```bash
flutter build ios  # iOS
flutter build apk  # Android
```
