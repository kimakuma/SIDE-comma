// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$missionRepositoryHash() => r'c35dbefb3f60abaede8d96f8223484fd36e82c00';

/// See also [missionRepository].
@ProviderFor(missionRepository)
final missionRepositoryProvider =
    AutoDisposeProvider<MissionRepository>.internal(
  missionRepository,
  name: r'missionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$missionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MissionRepositoryRef = AutoDisposeProviderRef<MissionRepository>;
String _$getMissionHash() => r'a53e546782f2c2ee2220e85cd58ac0e960d133f7';

/// See also [getMission].
@ProviderFor(getMission)
final getMissionProvider = AutoDisposeFutureProvider<String>.internal(
  getMission,
  name: r'getMissionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetMissionRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
