import '../models/mission.dart';
import '../database/mission.dart';
import '../../domain/repositories/mission_repository.dart';

class LocalMissionRepository implements MissionRepository {
  final MissionDatabase _database;

  LocalMissionRepository({MissionDatabase? database})
      : _database = database ?? MissionDatabase.instance;

  @override
  Future<String> getMission() async {
    return _database.getMission();
  }
} 