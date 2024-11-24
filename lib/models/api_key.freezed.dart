// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

APIKey _$APIKeyFromJson(Map<String, dynamic> json) {
  return _APIKey.fromJson(json);
}

/// @nodoc
mixin _$APIKey {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get secret => throw _privateConstructorUsedError;
  @HiveField(3)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this APIKey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of APIKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $APIKeyCopyWith<APIKey> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIKeyCopyWith<$Res> {
  factory $APIKeyCopyWith(APIKey value, $Res Function(APIKey) then) =
      _$APIKeyCopyWithImpl<$Res, APIKey>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String? secret,
      @HiveField(3) String userId,
      @HiveField(4) DateTime createdAt,
      @HiveField(5) DateTime updatedAt});
}

/// @nodoc
class _$APIKeyCopyWithImpl<$Res, $Val extends APIKey>
    implements $APIKeyCopyWith<$Res> {
  _$APIKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of APIKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? secret = freezed,
    Object? userId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$APIKeyImplCopyWith<$Res> implements $APIKeyCopyWith<$Res> {
  factory _$$APIKeyImplCopyWith(
          _$APIKeyImpl value, $Res Function(_$APIKeyImpl) then) =
      __$$APIKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String? secret,
      @HiveField(3) String userId,
      @HiveField(4) DateTime createdAt,
      @HiveField(5) DateTime updatedAt});
}

/// @nodoc
class __$$APIKeyImplCopyWithImpl<$Res>
    extends _$APIKeyCopyWithImpl<$Res, _$APIKeyImpl>
    implements _$$APIKeyImplCopyWith<$Res> {
  __$$APIKeyImplCopyWithImpl(
      _$APIKeyImpl _value, $Res Function(_$APIKeyImpl) _then)
      : super(_value, _then);

  /// Create a copy of APIKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? secret = freezed,
    Object? userId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$APIKeyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 6)
class _$APIKeyImpl extends _APIKey {
  _$APIKeyImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) this.secret,
      @HiveField(3) required this.userId,
      @HiveField(4) required this.createdAt,
      @HiveField(5) required this.updatedAt})
      : super._();

  factory _$APIKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$APIKeyImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String? secret;
  @override
  @HiveField(3)
  final String userId;
  @override
  @HiveField(4)
  final DateTime createdAt;
  @override
  @HiveField(5)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'APIKey(id: $id, name: $name, secret: $secret, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$APIKeyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.secret, secret) || other.secret == secret) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, secret, userId, createdAt, updatedAt);

  /// Create a copy of APIKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$APIKeyImplCopyWith<_$APIKeyImpl> get copyWith =>
      __$$APIKeyImplCopyWithImpl<_$APIKeyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$APIKeyImplToJson(
      this,
    );
  }
}

abstract class _APIKey extends APIKey {
  factory _APIKey(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) final String? secret,
      @HiveField(3) required final String userId,
      @HiveField(4) required final DateTime createdAt,
      @HiveField(5) required final DateTime updatedAt}) = _$APIKeyImpl;
  _APIKey._() : super._();

  factory _APIKey.fromJson(Map<String, dynamic> json) = _$APIKeyImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String? get secret;
  @override
  @HiveField(3)
  String get userId;
  @override
  @HiveField(4)
  DateTime get createdAt;
  @override
  @HiveField(5)
  DateTime get updatedAt;

  /// Create a copy of APIKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$APIKeyImplCopyWith<_$APIKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
