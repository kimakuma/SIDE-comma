class User {
  final String id;
  final String nickname;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.nickname,
    this.profileImageUrl,
  });

  factory User.fromKakaoUser(dynamic kakaoUser) {
    return User(
      id: kakaoUser.id.toString(),
      nickname: kakaoUser.kakaoAccount?.profile?.nickname ?? '사용자',
      profileImageUrl: kakaoUser.kakaoAccount?.profile?.profileImageUrl,
    );
  }
} 