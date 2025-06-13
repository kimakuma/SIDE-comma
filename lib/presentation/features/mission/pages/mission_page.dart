import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/api/mission_api.dart';

class MissionPage extends ConsumerStatefulWidget {
  const MissionPage({super.key});

  @override
  ConsumerState<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends ConsumerState<MissionPage> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  final String _currentMission = '오늘의 미션: 물 한 잔 마시기'; // 실제로는 서버나 상태 관리에서 가져와야 함
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _completeMission() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });
    _controller.reset();
    _controller.forward();

    try {
      print('미션 완료 API 요청 시작: $_currentMission');
      await ref.read(missionApiProvider).completeMission(_currentMission);
      print('미션 완료 API 요청 성공!');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('미션 완료!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('미션 완료 API 요청 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('미션 완료에 실패했습니다. 다시 시도해주세요.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _controller.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? SizedBox(
                width: 50,
                height: 50,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: _animation.value,
                      strokeWidth: 4,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    );
                  },
                ),
              )
            : GestureDetector(
                onTap: _completeMission,
                child: Text(
                  _currentMission,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
      ),
    );
  }
} 