import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../providers/mission_provider.dart';
import '../providers/water_level_provider.dart';
import '../../data/api/mission_api.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with TickerProviderStateMixin {
  String _displayText = '';
  String _fullText = '';
  bool _isLoading = true;
  String _errorMessage = '';
  
  late final AnimationController _waveController = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();
    _loadMission();
  }

  Future<void> _loadMission() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final mission = await ref.read(getMissionProvider.future);
      if (!mounted) return;
      setState(() {
        _fullText = mission;
        _displayText = mission;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _completeMission() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await ref.read(missionApiProvider).completeMission(_fullText);
      if (!mounted) return;
      
      setState(() {
        ref.read(waterLevelProvider.notifier).increaseWaterLevel();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.green,
        ),
      );
      _loadMission();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('미션 완료에 실패했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth * 0.5;
    final waterLevel = ref.watch(waterLevelProvider);
    
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 미션 텍스트
            Positioned(
              top: screenHeight * 0.15,
              left: 0,
              right: 0,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: _completeMission,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _displayText,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
            
            // 새로고침 버튼
            Positioned(
              top: screenHeight * 0.4,
              left: (screenWidth - 60) / 2,
              child: GestureDetector(
                onTap: _loadMission,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.3),
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
            ),
            
            // 물결 원
            Positioned(
              bottom: screenHeight * 0.2,
              left: (screenWidth - circleSize) / 2,
              width: circleSize,
              height: circleSize,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  if (waterLevel > 0)
                    AnimatedBuilder(
                      animation: _waveController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: WavePainter(
                            animation: _waveController,
                            fillPercent: waterLevel,
                            waveColor: Colors.blue.withOpacity(0.3),
                          ),
                          size: Size(circleSize, circleSize),
                        );
                      },
                    ),
                ],
              ),
            ),

            // 에러 메시지
            if (_errorMessage.isNotEmpty)
              Positioned(
                top: screenHeight * 0.3,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final double fillPercent;
  final Color waveColor;

  WavePainter({
    required this.animation,
    required this.fillPercent,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final path = Path();
    
    canvas.clipPath(Path()..addOval(rect));

    final waveHeight = size.height * 0.05;
    final baseHeight = size.height * (1 - fillPercent);
    
    path.moveTo(0, baseHeight);
    
    for (var i = 0.0; i <= size.width; i++) {
      path.lineTo(
        i,
        baseHeight + math.sin((animation.value * 360 + i) * math.pi / 180) * waveHeight,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.fillPercent != fillPercent ||
        oldDelegate.waveColor != waveColor;
  }
}