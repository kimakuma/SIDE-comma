import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'water_level_provider.g.dart';

@Riverpod(keepAlive: true)
class WaterLevel extends _$WaterLevel {
  @override
  double build() {
    return 0.0;  // 초기값 0%
  }

  void increaseWaterLevel() {
    state = double.parse((state + 0.2).toStringAsFixed(1));  // 20%씩 증가, 소수점 첫째자리까지만
    if (state > 1.0) state = 1.0;  // 최대 100%를 넘지 않도록
  }

  void resetWaterLevel() {
    state = 0.0;
  }
} 