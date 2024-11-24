// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_contract.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PointsContract _$PointsContractFromJson(Map<String, dynamic> json) {
  return _PointsContract.fromJson(json);
}

/// @nodoc
mixin _$PointsContract {
  @HiveField(0)
  String get address => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get symbol => throw _privateConstructorUsedError;
  @HiveField(3)
  int get decimals => throw _privateConstructorUsedError;
  @HiveField(4)
  String get description => throw _privateConstructorUsedError;
  @HiveField(5)
  int get totalSupply => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get balance => throw _privateConstructorUsedError;

  /// Serializes this PointsContract to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsContract
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsContractCopyWith<PointsContract> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsContractCopyWith<$Res> {
  factory $PointsContractCopyWith(
          PointsContract value, $Res Function(PointsContract) then) =
      _$PointsContractCopyWithImpl<$Res, PointsContract>;
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String name,
      @HiveField(2) String symbol,
      @HiveField(3) int decimals,
      @HiveField(4) String description,
      @HiveField(5) int totalSupply,
      @HiveField(6) String? balance});
}

/// @nodoc
class _$PointsContractCopyWithImpl<$Res, $Val extends PointsContract>
    implements $PointsContractCopyWith<$Res> {
  _$PointsContractCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsContract
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? description = null,
    Object? totalSupply = null,
    Object? balance = freezed,
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
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalSupply: null == totalSupply
          ? _value.totalSupply
          : totalSupply // ignore: cast_nullable_to_non_nullable
              as int,
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointsContractImplCopyWith<$Res>
    implements $PointsContractCopyWith<$Res> {
  factory _$$PointsContractImplCopyWith(_$PointsContractImpl value,
          $Res Function(_$PointsContractImpl) then) =
      __$$PointsContractImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String name,
      @HiveField(2) String symbol,
      @HiveField(3) int decimals,
      @HiveField(4) String description,
      @HiveField(5) int totalSupply,
      @HiveField(6) String? balance});
}

/// @nodoc
class __$$PointsContractImplCopyWithImpl<$Res>
    extends _$PointsContractCopyWithImpl<$Res, _$PointsContractImpl>
    implements _$$PointsContractImplCopyWith<$Res> {
  __$$PointsContractImplCopyWithImpl(
      _$PointsContractImpl _value, $Res Function(_$PointsContractImpl) _then)
      : super(_value, _then);

  /// Create a copy of PointsContract
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? description = null,
    Object? totalSupply = null,
    Object? balance = freezed,
  }) {
    return _then(_$PointsContractImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalSupply: null == totalSupply
          ? _value.totalSupply
          : totalSupply // ignore: cast_nullable_to_non_nullable
              as int,
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 4)
class _$PointsContractImpl extends _PointsContract {
  _$PointsContractImpl(
      {@HiveField(0) required this.address,
      @HiveField(1) required this.name,
      @HiveField(2) required this.symbol,
      @HiveField(3) required this.decimals,
      @HiveField(4) required this.description,
      @HiveField(5) required this.totalSupply,
      @HiveField(6) required this.balance})
      : super._();

  factory _$PointsContractImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsContractImplFromJson(json);

  @override
  @HiveField(0)
  final String address;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String symbol;
  @override
  @HiveField(3)
  final int decimals;
  @override
  @HiveField(4)
  final String description;
  @override
  @HiveField(5)
  final int totalSupply;
  @override
  @HiveField(6)
  final String? balance;

  @override
  String toString() {
    return 'PointsContract(address: $address, name: $name, symbol: $symbol, decimals: $decimals, description: $description, totalSupply: $totalSupply, balance: $balance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsContractImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.totalSupply, totalSupply) ||
                other.totalSupply == totalSupply) &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address, name, symbol, decimals,
      description, totalSupply, balance);

  /// Create a copy of PointsContract
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsContractImplCopyWith<_$PointsContractImpl> get copyWith =>
      __$$PointsContractImplCopyWithImpl<_$PointsContractImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsContractImplToJson(
      this,
    );
  }
}

abstract class _PointsContract extends PointsContract {
  factory _PointsContract(
      {@HiveField(0) required final String address,
      @HiveField(1) required final String name,
      @HiveField(2) required final String symbol,
      @HiveField(3) required final int decimals,
      @HiveField(4) required final String description,
      @HiveField(5) required final int totalSupply,
      @HiveField(6) required final String? balance}) = _$PointsContractImpl;
  _PointsContract._() : super._();

  factory _PointsContract.fromJson(Map<String, dynamic> json) =
      _$PointsContractImpl.fromJson;

  @override
  @HiveField(0)
  String get address;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get symbol;
  @override
  @HiveField(3)
  int get decimals;
  @override
  @HiveField(4)
  String get description;
  @override
  @HiveField(5)
  int get totalSupply;
  @override
  @HiveField(6)
  String? get balance;

  /// Create a copy of PointsContract
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsContractImplCopyWith<_$PointsContractImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
