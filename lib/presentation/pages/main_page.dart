import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/mission_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with TickerProviderStateMixin {
  String _displayText = '';
  String _fullText = '';
  int _charIndex = 0;
  bool _isAnimating = false;
  bool _isLoading = true;
  
  late final AnimationController _fallController = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  );

  late final Animation<double> _morphAnimation = CurvedAnimation(
    parent: _fallController,
    curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
  );

  late final Animation<double> _fallAnimation = CurvedAnimation(
    parent: _fallController,
    curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
  );

  @override
  void initState() {
    super.initState();
    _loadMission();
  }

  Future<void> _loadMission() async {
    final mission = await ref.read(getMissionProvider.future);
    setState(() {
      _fullText = mission;
      _isLoading = false;
    });
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    if (_isLoading) return;
    Future.delayed(const Duration(milliseconds: 500), () {
      _typeNextChar();
    });
  }

  void _typeNextChar() {
    if (_charIndex < _fullText.length) {
      setState(() {
        _displayText = _fullText.substring(0, _charIndex + 1);
        _charIndex++;
      });
      Future.delayed(const Duration(milliseconds: 200), _typeNextChar);
    }
  }

  void _startFallAnimation() {
    if (!_isAnimating && _charIndex >= _fullText.length) {
      setState(() {
        _isAnimating = true;
      });
      _fallController.forward();
    }
  }

  @override
  void dispose() {
    _fallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.25,
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: _startFallAnimation,
                        child: !_isAnimating
                          ? Text(
                              _displayText,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            )
                          : SizedBox(
                              width: screenWidth,
                              height: screenHeight * 0.7,
                              child: AnimatedBuilder(
                                animation: _fallController,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: LinePainter(
                                      text: _fullText,
                                      morphProgress: _morphAnimation.value,
                                      fallProgress: _fallAnimation.value,
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                      ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
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