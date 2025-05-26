// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Mission _$MissionFromJson(Map<String, dynamic> json) {
  return _Mission.fromJson(json);
}

/// @nodoc
mixin _$Mission {
  String get content => throw _privateConstructorUsedError;

  /// Serializes this Mission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionCopyWith<Mission> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionCopyWith<$Res> {
  factory $MissionCopyWith(Mission value, $Res Function(Mission) then) =
      _$MissionCopyWithImpl<$Res, Mission>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class _$MissionCopyWithImpl<$Res, $Val extends Mission>
    implements $MissionCopyWith<$Res> {
  _$MissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissionImplCopyWith<$Res> implements $MissionCopyWith<$Res> {
  factory _$$MissionImplCopyWith(
          _$MissionImpl value, $Res Function(_$MissionImpl) then) =
      __$$MissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$MissionImplCopyWithImpl<$Res>
    extends _$MissionCopyWithImpl<$Res, _$MissionImpl>
    implements _$$MissionImplCopyWith<$Res> {
  __$$MissionImplCopyWithImpl(
      _$MissionImpl _value, $Res Function(_$MissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$MissionImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionImpl implements _Mission {
  const _$MissionImpl({required this.content});

  factory _$MissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionImplFromJson(json);

  @override
  final String content;

  @override
  String toString() {
    return 'Mission(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      __$$MissionImplCopyWithImpl<_$MissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionImplToJson(
      this,
    );
  }
}

abstract class _Mission implements Mission {
  const factory _Mission({required final String content}) = _$MissionImpl;

  factory _Mission.fromJson(Map<String, dynamic> json) = _$MissionImpl.fromJson;

  @override
  String get content;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionList _$MissionListFromJson(Map<String, dynamic> json) {
  return _MissionList.fromJson(json);
}

/// @nodoc
mixin _$MissionList {
  List<Mission> get missions => throw _privateConstructorUsedError;

  /// Serializes this MissionList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionListCopyWith<MissionList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionListCopyWith<$Res> {
  factory $MissionListCopyWith(
          MissionList value, $Res Function(MissionList) then) =
      _$MissionListCopyWithImpl<$Res, MissionList>;
  @useResult
  $Res call({List<Mission> missions});
}

/// @nodoc
class _$MissionListCopyWithImpl<$Res, $Val extends MissionList>
    implements $MissionListCopyWith<$Res> {
  _$MissionListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missions = null,
  }) {
    return _then(_value.copyWith(
      missions: null == missions
          ? _value.missions
          : missions // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissionListImplCopyWith<$Res>
    implements $MissionListCopyWith<$Res> {
  factory _$$MissionListImplCopyWith(
          _$MissionListImpl value, $Res Function(_$MissionListImpl) then) =
      __$$MissionListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Mission> missions});
}

/// @nodoc
class __$$MissionListImplCopyWithImpl<$Res>
    extends _$MissionListCopyWithImpl<$Res, _$MissionListImpl>
    implements _$$MissionListImplCopyWith<$Res> {
  __$$MissionListImplCopyWithImpl(
      _$MissionListImpl _value, $Res Function(_$MissionListImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissionList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missions = null,
  }) {
    return _then(_$MissionListImpl(
      missions: null == missions
          ? _value._missions
          : missions // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionListImpl implements _MissionList {
  const _$MissionListImpl({required final List<Mission> missions})
      : _missions = missions;

  factory _$MissionListImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionListImplFromJson(json);

  final List<Mission> _missions;
  @override
  List<Mission> get missions {
    if (_missions is EqualUnmodifiableListView) return _missions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missions);
  }

  @override
  String toString() {
    return 'MissionList(missions: $missions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionListImpl &&
            const DeepCollectionEquality().equals(other._missions, _missions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_missions));

  /// Create a copy of MissionList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionListImplCopyWith<_$MissionListImpl> get copyWith =>
      __$$MissionListImplCopyWithImpl<_$MissionListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionListImplToJson(
      this,
    );
  }
}

abstract class _MissionList implements MissionList {
  const factory _MissionList({required final List<Mission> missions}) =
      _$MissionListImpl;

  factory _MissionList.fromJson(Map<String, dynamic> json) =
      _$MissionListImpl.fromJson;

  @override
  List<Mission> get missions;

  /// Create a copy of MissionList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionListImplCopyWith<_$MissionListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
