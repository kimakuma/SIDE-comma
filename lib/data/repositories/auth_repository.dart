import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/auth_token.dart';
import '../../domain/entities/user.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
class AuthRepository extends _$AuthRepository {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'user';
  
  @override
  Future<void> build() async {
    // 초기화 로직이 필요한 경우 여기에 작성
  }

  Future<void> saveAuthToken(AuthToken token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, jsonEncode(token.toJson()));
  }

  Future<AuthToken?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final tokenJson = prefs.getString(_tokenKey);
    if (tokenJson == null) return null;
    return AuthToken.fromJson(jsonDecode(tokenJson));
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode({
      'id': user.id,
      'nickname': user.nickname,
      'profileImageUrl': user.profileImageUrl,
    }));
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) return null;
    final Map<String, dynamic> data = jsonDecode(userJson);
    return User(
      id: data['id'],
      nickname: data['nickname'],
      profileImageUrl: data['profileImageUrl'],
    );
  }

  Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAuthToken();
    if (token == null) return false;
    return token.accessTokenExpiresAt.isAfter(DateTime.now());
  }
} 