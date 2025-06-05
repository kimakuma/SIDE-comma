import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../providers/mission_provider.dart';
import '../providers/water_level_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with TickerProviderStateMixin {
  String _displayText = '';
  String _fullText = '';
  bool _isAnimating = false;
  bool _isLoading = true;
  bool _isTypingComplete = false;
  int _charIndex = 0;
  
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

  @override
  void initState() {
    super.initState();
    _loadMission();
  }

  Future<void> _loadMission() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _isAnimating = false;
      _isTypingComplete = false;
      _charIndex = 0;
      _displayText = '';
    });

    final mission = await ref.read(getMissionProvider.future);
    if (!mounted) return;
    setState(() {
      _fullText = mission;
      _isLoading = false;
    });
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    if (_isLoading) return;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      _typeNextChar();
    });
  }

  void _typeNextChar() {
    if (!mounted) return;
    if (_charIndex < _fullText.length) {
      setState(() {
        _displayText = _fullText.substring(0, _charIndex + 1);
        _charIndex++;
      });
      Future.delayed(const Duration(milliseconds: 200), _typeNextChar);
    } else {
      setState(() {
        _isTypingComplete = true;
      });
    }
  }

  void _startShrinkAnimation() {
    if (!_isAnimating && _isTypingComplete) {
      setState(() {
        _isAnimating = true;
      });
      ref.read(waterLevelProvider.notifier).increaseWaterLevel();
      _shrinkController.forward().then((_) {
        if (!mounted) return;
        _loadMission();
      });
    }
  }

  void _resetMission() {
    _shrinkController.reset();
    _loadMission();
  }

  @override
  void dispose() {
    _shrinkController.dispose();
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
            // 텍스트 애니메이션
            Positioned(
              top: screenHeight * 0.15,
              left: 0,
              right: 0,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: _startShrinkAnimation,
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
                                child: Text(
                                  _displayText,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
            
            // 새로고침 버튼
            Positioned(
              top: screenHeight * 0.4,
              left: (screenWidth - 60) / 2,
              child: GestureDetector(
                onTap: _resetMission,
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
                  if (_isAnimating || waterLevel > 0)
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
    
    canvas.drawPath(path, Paint()..color = waveColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class LinePainter extends CustomPainter {
  final String text;
  final double morphProgress;
  final double fallProgress;
  final TextStyle style;

  LinePainter({
    required this.text,
    required this.morphProgress,
    required this.fallProgress,
    required this.style,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    final textWidth = textPainter.width;
    final lineWidth = textWidth * 1.2; // 선의 길이는 텍스트보다 약간 길게
    
    final startX = (size.width - lineWidth) / 2;
    final startY = size.height * 0.2;
    final endY = size.height * 0.8;
    
    // 텍스트 그리기 (모프 진행에 따라 페이드 아웃)
    if (morphProgress < 1.0) {
      textPainter.paint(
        canvas, 
        Offset(
          (size.width - textWidth) / 2,
          startY + (fallProgress * (endY - startY)),
        ),
      );
    }

    // 선 그리기
    final paint = Paint()
      ..color = Colors.blue.withOpacity(morphProgress)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // 선이 중앙에서 시작하여 양쪽으로 늘어나는 효과
    final currentLineWidth = lineWidth * morphProgress;
    final lineStartX = startX + (lineWidth - currentLineWidth) / 2;
    final lineY = startY + (fallProgress * (endY - startY));

    canvas.drawLine(
      Offset(lineStartX, lineY),
      Offset(lineStartX + currentLineWidth, lineY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}