import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_token.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  Future<User?> build() async {
    final repository = ref.watch(authRepositoryProvider.notifier);
    
    if (!await repository.isLoggedIn()) {
      return null;
    }
    
    return repository.getUser();
  }

  Future<void> login(User user, String accessToken, String? refreshToken) async {
    final repository = ref.read(authRepositoryProvider.notifier);

    final token = AuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
      accessTokenExpiresAt: DateTime.now().add(const Duration(hours: 1)),
      refreshTokenExpiresAt: DateTime.now().add(const Duration(days: 30)),
    );

    await repository.saveAuthToken(token);
    await repository.saveUser(user);
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider.notifier);
    await repository.clearAuth();
    state = const AsyncValue.data(null);
  }
} 