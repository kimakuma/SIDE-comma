import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission.freezed.dart';
part 'mission.g.dart';

@freezed
class Mission with _$Mission {
  const factory Mission({
    required String content,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) => _$MissionFromJson(json);
}

@freezed
class MissionList with _$MissionList {
  const factory MissionList({
    required List<Mission> missions,
  }) = _MissionList;

  factory MissionList.fromJson(Map<String, dynamic> json) => _$MissionListFromJson(json);
} 