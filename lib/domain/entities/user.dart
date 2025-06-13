class User {
  final String id;
  final String nickname;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.nickname,
    this.profileImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  factory User.fromKakaoUser(dynamic kakaoUser) {
    return User(
      id: kakaoUser.id.toString(),
      nickname: kakaoUser.kakaoAccount?.profile?.nickname ?? '사용자',
      profileImageUrl: kakaoUser.kakaoAccount?.profile?.profileImageUrl,
    );
  }
} 