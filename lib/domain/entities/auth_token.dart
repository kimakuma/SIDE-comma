class AuthToken {
  final String accessToken;
  final String? refreshToken;
  final DateTime accessTokenExpiresAt;
  final DateTime? refreshTokenExpiresAt;

  AuthToken({
    required this.accessToken,
    this.refreshToken,
    required this.accessTokenExpiresAt,
    this.refreshTokenExpiresAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'accessTokenExpiresAt': accessTokenExpiresAt.toIso8601String(),
      'refreshTokenExpiresAt': refreshTokenExpiresAt?.toIso8601String(),
    };
  }

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      accessTokenExpiresAt: DateTime.parse(json['accessTokenExpiresAt'] as String),
      refreshTokenExpiresAt: json['refreshTokenExpiresAt'] != null
          ? DateTime.parse(json['refreshTokenExpiresAt'] as String)
          : null,
    );
  }
} 