import 'package:json_annotation/json_annotation.dart';

part 'mission_completion.g.dart';

@JsonSerializable()
class MissionCompletion {
  final String mission;
  @JsonKey(name: 'create_dt')
  final DateTime createDt;
  @JsonKey(name: 'user_id')
  final String userId;

  MissionCompletion({
    required this.mission,
    required this.createDt,
    required this.userId,
  });

  factory MissionCompletion.fromJson(Map<String, dynamic> json) => 
      _$MissionCompletionFromJson(json);

  Map<String, dynamic> toJson() => _$MissionCompletionToJson(this);
} 