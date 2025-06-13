import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../../../data/api/mission_api.dart';

class MissionPage extends ConsumerStatefulWidget {
  const MissionPage({super.key});

  @override
  ConsumerState<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends ConsumerState<MissionPage> with TickerProviderStateMixin {
  late final AnimationController _shrinkController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  late final AnimationController _waveController = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  )..repeat();

  late final Animation<double> _shrinkAnimation = CurvedAnimation(
    parent: _shrinkController,
    curve: Curves.easeInOut,
  );

  bool _isLoading = false;
  bool _isAnimating = false;
  String _errorMessage = '';
  double _waterLevel = 0.0;

  @override
  void dispose() {
    _shrinkController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  Future<void> _completeMission(String mission) async {
    if (_isLoading || _isAnimating) return;

    setState(() {
      _isLoading = true;
      _isAnimating = true;
      _errorMessage = '';
    });

    _shrinkController.forward().then((_) async {
      try {
        final response = await ref.read(missionApiProvider).completeMission(mission);
        if (mounted) {
          setState(() {
            _waterLevel += 0.2; // 물결 레벨 증가
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _errorMessage = e.toString();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('미션 완료에 실패했습니다: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _isAnimating = false;
          });
          _shrinkController.reset();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth * 0.5;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 미션'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _errorMessage = '';
                _waterLevel = 0.0;
              });
              _shrinkController.reset();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 미션 카드
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  GestureDetector(
                    onTap: () => _completeMission('오늘의 미션: 물 한 잔 마시기'),
                    child: AnimatedBuilder(
                      animation: _shrinkAnimation,
                      builder: (context, child) {
                        final scale = 1.0 - (_shrinkAnimation.value * 0.8);
                        final opacity = 1.0 - _shrinkAnimation.value;
                        final moveDown = _shrinkAnimation.value * screenHeight * 0.3;
                        
                        return Transform.translate(
                          offset: Offset(0, moveDown),
                          child: Opacity(
                            opacity: opacity,
                            child: Transform.scale(
                              scale: scale,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.water_drop,
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '오늘의 미션: 물 한 잔 마시기',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
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
                if (_isAnimating || _waterLevel > 0)
                  AnimatedBuilder(
                    animation: _waveController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: WavePainter(
                          animation: _waveController,
                          fillPercent: _waterLevel,
                          waveColor: Colors.blue.withOpacity(0.3),
                        ),
                        size: Size(circleSize, circleSize),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
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