// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merchant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Merchant _$MerchantFromJson(Map<String, dynamic> json) {
  return _Merchant.fromJson(json);
}

/// @nodoc
mixin _$Merchant {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get address => throw _privateConstructorUsedError;
  @HiveField(3)
  int get decimals => throw _privateConstructorUsedError;
  @HiveField(4)
  String get symbol => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Merchant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Merchant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MerchantCopyWith<Merchant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MerchantCopyWith<$Res> {
  factory $MerchantCopyWith(Merchant value, $Res Function(Merchant) then) =
      _$MerchantCopyWithImpl<$Res, Merchant>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String address,
      @HiveField(3) int decimals,
      @HiveField(4) String symbol,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) DateTime updatedAt});
}

/// @nodoc
class _$MerchantCopyWithImpl<$Res, $Val extends Merchant>
    implements $MerchantCopyWith<$Res> {
  _$MerchantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Merchant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? decimals = null,
    Object? symbol = null,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
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
abstract class _$$MerchantImplCopyWith<$Res>
    implements $MerchantCopyWith<$Res> {
  factory _$$MerchantImplCopyWith(
          _$MerchantImpl value, $Res Function(_$MerchantImpl) then) =
      __$$MerchantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String address,
      @HiveField(3) int decimals,
      @HiveField(4) String symbol,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) DateTime updatedAt});
}

/// @nodoc
class __$$MerchantImplCopyWithImpl<$Res>
    extends _$MerchantCopyWithImpl<$Res, _$MerchantImpl>
    implements _$$MerchantImplCopyWith<$Res> {
  __$$MerchantImplCopyWithImpl(
      _$MerchantImpl _value, $Res Function(_$MerchantImpl) _then)
      : super(_value, _then);

  /// Create a copy of Merchant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? decimals = null,
    Object? symbol = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$MerchantImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
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
@HiveType(typeId: 3)
class _$MerchantImpl extends _Merchant {
  _$MerchantImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.address,
      @HiveField(3) required this.decimals,
      @HiveField(4) required this.symbol,
      @HiveField(5) required this.createdAt,
      @HiveField(6) required this.updatedAt})
      : super._();

  factory _$MerchantImpl.fromJson(Map<String, dynamic> json) =>
      _$$MerchantImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String address;
  @override
  @HiveField(3)
  final int decimals;
  @override
  @HiveField(4)
  final String symbol;
  @override
  @HiveField(5)
  final DateTime createdAt;
  @override
  @HiveField(6)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Merchant(id: $id, name: $name, address: $address, decimals: $decimals, symbol: $symbol, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MerchantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, address, decimals, symbol, createdAt, updatedAt);

  /// Create a copy of Merchant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MerchantImplCopyWith<_$MerchantImpl> get copyWith =>
      __$$MerchantImplCopyWithImpl<_$MerchantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MerchantImplToJson(
      this,
    );
  }
}

abstract class _Merchant extends Merchant {
  factory _Merchant(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String address,
      @HiveField(3) required final int decimals,
      @HiveField(4) required final String symbol,
      @HiveField(5) required final DateTime createdAt,
      @HiveField(6) required final DateTime updatedAt}) = _$MerchantImpl;
  _Merchant._() : super._();

  factory _Merchant.fromJson(Map<String, dynamic> json) =
      _$MerchantImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get address;
  @override
  @HiveField(3)
  int get decimals;
  @override
  @HiveField(4)
  String get symbol;
  @override
  @HiveField(5)
  DateTime get createdAt;
  @override
  @HiveField(6)
  DateTime get updatedAt;

  /// Create a copy of Merchant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MerchantImplCopyWith<_$MerchantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
