import '../../data/models/mission.dart';

abstract class MissionRepository {
  Future<String> getMission();
} 