// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_contract.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedContractImplAdapter extends TypeAdapter<_$SavedContractImpl> {
  @override
  final int typeId = 7;

  @override
  _$SavedContractImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SavedContractImpl(
      address: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as String,
      addedAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$SavedContractImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedContractImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedContractImpl _$$SavedContractImplFromJson(Map<String, dynamic> json) =>
    _$SavedContractImpl(
      address: json['address'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$$SavedContractImplToJson(_$SavedContractImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'type': instance.type,
      'addedAt': instance.addedAt.toIso8601String(),
    };
