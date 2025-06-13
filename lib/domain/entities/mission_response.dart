import 'package:json_annotation/json_annotation.dart';

part 'mission_response.g.dart';

@JsonSerializable()
class MissionResponse {
  final bool success;
  final String message;
  final String id;

  MissionResponse({
    required this.success,
    required this.message,
    required this.id,
  });

  factory MissionResponse.fromJson(Map<String, dynamic> json) => 
      _$MissionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MissionResponseToJson(this);
} 