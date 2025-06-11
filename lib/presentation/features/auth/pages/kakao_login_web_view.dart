import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/api/api_client.dart';
import '../../../../domain/entities/auth_response.dart';
import '../../../../core/config/env.dart';

class KakaoLoginWebView extends ConsumerStatefulWidget {
  const KakaoLoginWebView({super.key});

  @override
  ConsumerState<KakaoLoginWebView> createState() => _KakaoLoginWebViewState();
}

class _KakaoLoginWebViewState extends ConsumerState<KakaoLoginWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.startsWith(Env.redirectUri)) {
              final uri = Uri.parse(request.url);
              final code = uri.queryParameters['code'];
              if (code != null) {
                _handleAuthCode(code);
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://kauth.kakao.com/oauth/authorize?client_id=${Env.kakaoRestApiKey}&redirect_uri=${Env.redirectUri}&response_type=code',
        ),
      );
  }

  Future<void> _handleAuthCode(String code) async {
    try {
      final response = await ref.read(authApiProvider).signInWithKakao(
        body: {
          'code': code,
          'redirectUri': Env.redirectUri,
        },
      );

      if (mounted) {
        Navigator.of(context).pop(response);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그인에 실패했습니다. 다시 시도해주세요.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카카오 로그인'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
} 