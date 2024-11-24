// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collectible_contract.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollectibleContract _$CollectibleContractFromJson(Map<String, dynamic> json) {
  return _CollectibleContract.fromJson(json);
}

/// @nodoc
mixin _$CollectibleContract {
  @HiveField(0)
  String get address => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String get pointsContract => throw _privateConstructorUsedError;
  @HiveField(4)
  List<String> get tokenIds => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get tokenDescriptions => throw _privateConstructorUsedError;
  @HiveField(6)
  List<String> get tokenPrices => throw _privateConstructorUsedError;
  @HiveField(7)
  List<int> get tokenExpiries => throw _privateConstructorUsedError;
  @HiveField(8)
  List<String>? get tokenBalances => throw _privateConstructorUsedError;
  @HiveField(9)
  List<String>? get tokenSupplies => throw _privateConstructorUsedError;

  /// Serializes this CollectibleContract to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectibleContract
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectibleContractCopyWith<CollectibleContract> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectibleContractCopyWith<$Res> {
  factory $CollectibleContractCopyWith(
          CollectibleContract value, $Res Function(CollectibleContract) then) =
      _$CollectibleContractCopyWithImpl<$Res, CollectibleContract>;
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String name,
      @HiveField(2) String description,
      @HiveField(3) String pointsContract,
      @HiveField(4) List<String> tokenIds,
      @HiveField(5) List<String> tokenDescriptions,
      @HiveField(6) List<String> tokenPrices,
      @HiveField(7) List<int> tokenExpiries,
      @HiveField(8) List<String>? tokenBalances,
      @HiveField(9) List<String>? tokenSupplies});
}

/// @nodoc
class _$CollectibleContractCopyWithImpl<$Res, $Val extends CollectibleContract>
    implements $CollectibleContractCopyWith<$Res> {
  _$CollectibleContractCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectibleContract
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? description = null,
    Object? pointsContract = null,
    Object? tokenIds = null,
    Object? tokenDescriptions = null,
    Object? tokenPrices = null,
    Object? tokenExpiries = null,
    Object? tokenBalances = freezed,
    Object? tokenSupplies = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pointsContract: null == pointsContract
          ? _value.pointsContract
          : pointsContract // ignore: cast_nullable_to_non_nullable
              as String,
      tokenIds: null == tokenIds
          ? _value.tokenIds
          : tokenIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tokenDescriptions: null == tokenDescriptions
          ? _value.tokenDescriptions
          : tokenDescriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tokenPrices: null == tokenPrices
          ? _value.tokenPrices
          : tokenPrices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tokenExpiries: null == tokenExpiries
          ? _value.tokenExpiries
          : tokenExpiries // ignore: cast_nullable_to_non_nullable
              as List<int>,
      tokenBalances: freezed == tokenBalances
          ? _value.tokenBalances
          : tokenBalances // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tokenSupplies: freezed == tokenSupplies
          ? _value.tokenSupplies
          : tokenSupplies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectibleContractImplCopyWith<$Res>
    implements $CollectibleContractCopyWith<$Res> {
  factory _$$CollectibleContractImplCopyWith(_$CollectibleContractImpl value,
          $Res Function(_$CollectibleContractImpl) then) =
      __$$CollectibleContractImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String name,
      @HiveField(2) String description,
      @HiveField(3) String pointsContract,
      @HiveField(4) List<String> tokenIds,
      @HiveField(5) List<String> tokenDescriptions,
      @HiveField(6) List<String> tokenPrices,
      @HiveField(7) List<int> tokenExpiries,
      @HiveField(8) List<String>? tokenBalances,
      @HiveField(9) List<String>? tokenSupplies});
}

/// @nodoc
class __$$CollectibleContractImplCopyWithImpl<$Res>
    extends _$CollectibleContractCopyWithImpl<$Res, _$CollectibleContractImpl>
    implements _$$CollectibleContractImplCopyWith<$Res> {
  __$$CollectibleContractImplCopyWithImpl(_$CollectibleContractImpl _value,
      $Res Function(_$CollectibleContractImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectibleContract
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? description = null,
    Object? pointsContract = null,
    Object? tokenIds = null,
    Object? tokenDescriptions = null,
    Object? tokenPrices = null,
    Object? tokenExpiries = null,
    Object? tokenBalances = freezed,
    Object? tokenSupplies = freezed,
  }) {
    return _then(_$CollectibleContractImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pointsContract: null == pointsContract
          ? _value.pointsContract
          : pointsContract // ignore: cast_nullable_to_non_nullable
              as String,
      tokenIds: null == tokenIds
          ? _value._tokenIds
          : tokenIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tokenDescriptions: null == tokenDescriptions
          ? _value._tokenDescriptions
          : tokenDescriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tokenPrices: null == tokenPrices
          ? _value._tokenPrices
          : tokenPrices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tokenExpiries: null == tokenExpiries
          ? _value._tokenExpiries
          : tokenExpiries // ignore: cast_nullable_to_non_nullable
              as List<int>,
      tokenBalances: freezed == tokenBalances
          ? _value._tokenBalances
          : tokenBalances // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tokenSupplies: freezed == tokenSupplies
          ? _value._tokenSupplies
          : tokenSupplies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 5)
class _$CollectibleContractImpl extends _CollectibleContract {
  _$CollectibleContractImpl(
      {@HiveField(0) required this.address,
      @HiveField(1) required this.name,
      @HiveField(2) required this.description,
      @HiveField(3) required this.pointsContract,
      @HiveField(4) required final List<String> tokenIds,
      @HiveField(5) required final List<String> tokenDescriptions,
      @HiveField(6) required final List<String> tokenPrices,
      @HiveField(7) required final List<int> tokenExpiries,
      @HiveField(8) required final List<String>? tokenBalances,
      @HiveField(9) required final List<String>? tokenSupplies})
      : _tokenIds = tokenIds,
        _tokenDescriptions = tokenDescriptions,
        _tokenPrices = tokenPrices,
        _tokenExpiries = tokenExpiries,
        _tokenBalances = tokenBalances,
        _tokenSupplies = tokenSupplies,
        super._();

  factory _$CollectibleContractImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectibleContractImplFromJson(json);

  @override
  @HiveField(0)
  final String address;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String description;
  @override
  @HiveField(3)
  final String pointsContract;
  final List<String> _tokenIds;
  @override
  @HiveField(4)
  List<String> get tokenIds {
    if (_tokenIds is EqualUnmodifiableListView) return _tokenIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokenIds);
  }

  final List<String> _tokenDescriptions;
  @override
  @HiveField(5)
  List<String> get tokenDescriptions {
    if (_tokenDescriptions is EqualUnmodifiableListView)
      return _tokenDescriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokenDescriptions);
  }

  final List<String> _tokenPrices;
  @override
  @HiveField(6)
  List<String> get tokenPrices {
    if (_tokenPrices is EqualUnmodifiableListView) return _tokenPrices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokenPrices);
  }

  final List<int> _tokenExpiries;
  @override
  @HiveField(7)
  List<int> get tokenExpiries {
    if (_tokenExpiries is EqualUnmodifiableListView) return _tokenExpiries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokenExpiries);
  }

  final List<String>? _tokenBalances;
  @override
  @HiveField(8)
  List<String>? get tokenBalances {
    final value = _tokenBalances;
    if (value == null) return null;
    if (_tokenBalances is EqualUnmodifiableListView) return _tokenBalances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tokenSupplies;
  @override
  @HiveField(9)
  List<String>? get tokenSupplies {
    final value = _tokenSupplies;
    if (value == null) return null;
    if (_tokenSupplies is EqualUnmodifiableListView) return _tokenSupplies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CollectibleContract(address: $address, name: $name, description: $description, pointsContract: $pointsContract, tokenIds: $tokenIds, tokenDescriptions: $tokenDescriptions, tokenPrices: $tokenPrices, tokenExpiries: $tokenExpiries, tokenBalances: $tokenBalances, tokenSupplies: $tokenSupplies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectibleContractImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pointsContract, pointsContract) ||
                other.pointsContract == pointsContract) &&
            const DeepCollectionEquality().equals(other._tokenIds, _tokenIds) &&
            const DeepCollectionEquality()
                .equals(other._tokenDescriptions, _tokenDescriptions) &&
            const DeepCollectionEquality()
                .equals(other._tokenPrices, _tokenPrices) &&
            const DeepCollectionEquality()
                .equals(other._tokenExpiries, _tokenExpiries) &&
            const DeepCollectionEquality()
                .equals(other._tokenBalances, _tokenBalances) &&
            const DeepCollectionEquality()
                .equals(other._tokenSupplies, _tokenSupplies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      address,
      name,
      description,
      pointsContract,
      const DeepCollectionEquality().hash(_tokenIds),
      const DeepCollectionEquality().hash(_tokenDescriptions),
      const DeepCollectionEquality().hash(_tokenPrices),
      const DeepCollectionEquality().hash(_tokenExpiries),
      const DeepCollectionEquality().hash(_tokenBalances),
      const DeepCollectionEquality().hash(_tokenSupplies));

  /// Create a copy of CollectibleContract
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectibleContractImplCopyWith<_$CollectibleContractImpl> get copyWith =>
      __$$CollectibleContractImplCopyWithImpl<_$CollectibleContractImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectibleContractImplToJson(
      this,
    );
  }
}

abstract class _CollectibleContract extends CollectibleContract {
  factory _CollectibleContract(
          {@HiveField(0) required final String address,
          @HiveField(1) required final String name,
          @HiveField(2) required final String description,
          @HiveField(3) required final String pointsContract,
          @HiveField(4) required final List<String> tokenIds,
          @HiveField(5) required final List<String> tokenDescriptions,
          @HiveField(6) required final List<String> tokenPrices,
          @HiveField(7) required final List<int> tokenExpiries,
          @HiveField(8) required final List<String>? tokenBalances,
          @HiveField(9) required final List<String>? tokenSupplies}) =
      _$CollectibleContractImpl;
  _CollectibleContract._() : super._();

  factory _CollectibleContract.fromJson(Map<String, dynamic> json) =
      _$CollectibleContractImpl.fromJson;

  @override
  @HiveField(0)
  String get address;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get description;
  @override
  @HiveField(3)
  String get pointsContract;
  @override
  @HiveField(4)
  List<String> get tokenIds;
  @override
  @HiveField(5)
  List<String> get tokenDescriptions;
  @override
  @HiveField(6)
  List<String> get tokenPrices;
  @override
  @HiveField(7)
  List<int> get tokenExpiries;
  @override
  @HiveField(8)
  List<String>? get tokenBalances;
  @override
  @HiveField(9)
  List<String>? get tokenSupplies;

  /// Create a copy of CollectibleContract
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectibleContractImplCopyWith<_$CollectibleContractImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
