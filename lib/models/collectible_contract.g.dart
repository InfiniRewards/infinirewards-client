// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collectible_contract.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectibleContractImplAdapter
    extends TypeAdapter<_$CollectibleContractImpl> {
  @override
  final int typeId = 5;

  @override
  _$CollectibleContractImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$CollectibleContractImpl(
      address: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      pointsContract: fields[3] as String,
      tokenIds: (fields[4] as List).cast<String>(),
      tokenDescriptions: (fields[5] as List).cast<String>(),
      tokenPrices: (fields[6] as List).cast<String>(),
      tokenExpiries: (fields[7] as List).cast<int>(),
      tokenBalances: (fields[8] as List?)?.cast<String>(),
      tokenSupplies: (fields[9] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$CollectibleContractImpl obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.pointsContract)
      ..writeByte(4)
      ..write(obj.tokenIds)
      ..writeByte(5)
      ..write(obj.tokenDescriptions)
      ..writeByte(6)
      ..write(obj.tokenPrices)
      ..writeByte(7)
      ..write(obj.tokenExpiries)
      ..writeByte(8)
      ..write(obj.tokenBalances)
      ..writeByte(9)
      ..write(obj.tokenSupplies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectibleContractImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectibleContractImpl _$$CollectibleContractImplFromJson(
        Map<String, dynamic> json) =>
    _$CollectibleContractImpl(
      address: json['address'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pointsContract: json['pointsContract'] as String,
      tokenIds:
          (json['tokenIds'] as List<dynamic>).map((e) => e as String).toList(),
      tokenDescriptions: (json['tokenDescriptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tokenPrices: (json['tokenPrices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tokenExpiries: (json['tokenExpiries'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      tokenBalances: (json['tokenBalances'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tokenSupplies: (json['tokenSupplies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CollectibleContractImplToJson(
        _$CollectibleContractImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'description': instance.description,
      'pointsContract': instance.pointsContract,
      'tokenIds': instance.tokenIds,
      'tokenDescriptions': instance.tokenDescriptions,
      'tokenPrices': instance.tokenPrices,
      'tokenExpiries': instance.tokenExpiries,
      'tokenBalances': instance.tokenBalances,
      'tokenSupplies': instance.tokenSupplies,
    };
