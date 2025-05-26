// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MissionImpl _$$MissionImplFromJson(Map<String, dynamic> json) =>
    _$MissionImpl(
      content: json['content'] as String,
    );

Map<String, dynamic> _$$MissionImplToJson(_$MissionImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

_$MissionListImpl _$$MissionListImplFromJson(Map<String, dynamic> json) =>
    _$MissionListImpl(
      missions: (json['missions'] as List<dynamic>)
          .map((e) => Mission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MissionListImplToJson(_$MissionListImpl instance) =>
    <String, dynamic>{
      'missions': instance.missions,
    };
