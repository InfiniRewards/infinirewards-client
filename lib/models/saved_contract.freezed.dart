// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_contract.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SavedContract _$SavedContractFromJson(Map<String, dynamic> json) {
  return _SavedContract.fromJson(json);
}

/// @nodoc
mixin _$SavedContract {
  @HiveField(0)
  String get address => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get type =>
      throw _privateConstructorUsedError; // 'points' or 'collectible'
  @HiveField(3)
  DateTime get addedAt => throw _privateConstructorUsedError;

  /// Serializes this SavedContract to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedContract
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedContractCopyWith<SavedContract> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedContractCopyWith<$Res> {
  factory $SavedContractCopyWith(
          SavedContract value, $Res Function(SavedContract) then) =
      _$SavedContractCopyWithImpl<$Res, SavedContract>;
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String name,
      @HiveField(2) String type,
      @HiveField(3) DateTime addedAt});
}

/// @nodoc
class _$SavedContractCopyWithImpl<$Res, $Val extends SavedContract>
    implements $SavedContractCopyWith<$Res> {
  _$SavedContractCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedContract
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? type = null,
    Object? addedAt = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavedContractImplCopyWith<$Res>
    implements $SavedContractCopyWith<$Res> {
  factory _$$SavedContractImplCopyWith(
          _$SavedContractImpl value, $Res Function(_$SavedContractImpl) then) =
      __$$SavedContractImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String name,
      @HiveField(2) String type,
      @HiveField(3) DateTime addedAt});
}

/// @nodoc
class __$$SavedContractImplCopyWithImpl<$Res>
    extends _$SavedContractCopyWithImpl<$Res, _$SavedContractImpl>
    implements _$$SavedContractImplCopyWith<$Res> {
  __$$SavedContractImplCopyWithImpl(
      _$SavedContractImpl _value, $Res Function(_$SavedContractImpl) _then)
      : super(_value, _then);

  /// Create a copy of SavedContract
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? type = null,
    Object? addedAt = null,
  }) {
    return _then(_$SavedContractImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 7)
class _$SavedContractImpl extends _SavedContract {
  _$SavedContractImpl(
      {@HiveField(0) required this.address,
      @HiveField(1) required this.name,
      @HiveField(2) required this.type,
      @HiveField(3) required this.addedAt})
      : super._();

  factory _$SavedContractImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedContractImplFromJson(json);

  @override
  @HiveField(0)
  final String address;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String type;
// 'points' or 'collectible'
  @override
  @HiveField(3)
  final DateTime addedAt;

  @override
  String toString() {
    return 'SavedContract(address: $address, name: $name, type: $type, addedAt: $addedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedContractImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address, name, type, addedAt);

  /// Create a copy of SavedContract
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedContractImplCopyWith<_$SavedContractImpl> get copyWith =>
      __$$SavedContractImplCopyWithImpl<_$SavedContractImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedContractImplToJson(
      this,
    );
  }
}

abstract class _SavedContract extends SavedContract {
  factory _SavedContract(
      {@HiveField(0) required final String address,
      @HiveField(1) required final String name,
      @HiveField(2) required final String type,
      @HiveField(3) required final DateTime addedAt}) = _$SavedContractImpl;
  _SavedContract._() : super._();

  factory _SavedContract.fromJson(Map<String, dynamic> json) =
      _$SavedContractImpl.fromJson;

  @override
  @HiveField(0)
  String get address;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get type; // 'points' or 'collectible'
  @override
  @HiveField(3)
  DateTime get addedAt;

  /// Create a copy of SavedContract
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedContractImplCopyWith<_$SavedContractImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
