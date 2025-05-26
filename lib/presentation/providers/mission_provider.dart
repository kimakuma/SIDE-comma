import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/mission.dart';
import '../../domain/repositories/mission_repository.dart';
import '../../data/repositories/local_mission_repository.dart';

part 'mission_provider.g.dart';

@riverpod
MissionRepository missionRepository(MissionRepositoryRef ref) {
  return LocalMissionRepository();
}

@riverpod
Future<String> getMission(GetMissionRef ref) {
  final repository = ref.watch(missionRepositoryProvider);
  return repository.getMission();
}