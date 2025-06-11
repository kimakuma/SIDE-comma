import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/auth_token.dart';
import '../../domain/models/user.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
class AuthRepository extends _$AuthRepository {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'user_data';
  
  late final SharedPreferences _prefs;
  
  @override
  Future<void> build() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveAuthToken(AuthToken token) async {
    await _prefs.setString(_tokenKey, jsonEncode(token.toJson()));
  }

  Future<AuthToken?> getAuthToken() async {
    final tokenJson = _prefs.getString(_tokenKey);
    if (tokenJson == null) return null;
    return AuthToken.fromJson(jsonDecode(tokenJson));
  }

  Future<void> saveUser(User user) async {
    await _prefs.setString(_userKey, jsonEncode({
      'id': user.id,
      'nickname': user.nickname,
      'profileImageUrl': user.profileImageUrl,
    }));
  }

  Future<User?> getUser() async {
    final userJson = _prefs.getString(_userKey);
    if (userJson == null) return null;
    final userData = jsonDecode(userJson);
    return User(
      id: userData['id'],
      nickname: userData['nickname'],
      profileImageUrl: userData['profileImageUrl'],
    );
  }

  Future<void> clearAuth() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAuthToken();
    if (token == null) return false;
    return token.accessTokenExpiresAt.isAfter(DateTime.now());
  }
} 