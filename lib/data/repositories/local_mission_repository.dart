import 'dart:math';
import '../../domain/repositories/mission_repository.dart';

class LocalMissionRepository implements MissionRepository {
  final Random _random = Random();
  final List<String> _missions = [
    '오늘 하루 감사한 일 적어보기',
    '좋아하는 사람에게 칭찬 한마디 하기',
    '5분 동안 명상하기',
    '새로운 장소 방문하기',
    '오늘 하루 운동 30분 하기'
  ];

  @override
  Future<String> getRandomMission() async {
    return _missions[_random.nextInt(_missions.length)];
  }
} 