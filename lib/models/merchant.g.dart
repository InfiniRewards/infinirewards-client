// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MerchantImplAdapter extends TypeAdapter<_$MerchantImpl> {
  @override
  final int typeId = 3;

  @override
  _$MerchantImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$MerchantImpl(
      id: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      decimals: fields[3] as int,
      symbol: fields[4] as String,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$MerchantImpl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.decimals)
      ..writeByte(4)
      ..write(obj.symbol)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MerchantImpl _$$MerchantImplFromJson(Map<String, dynamic> json) =>
    _$MerchantImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      decimals: (json['decimals'] as num).toInt(),
      symbol: json['symbol'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MerchantImplToJson(_$MerchantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'decimals': instance.decimals,
      'symbol': instance.symbol,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
