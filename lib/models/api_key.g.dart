// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class APIKeyImplAdapter extends TypeAdapter<_$APIKeyImpl> {
  @override
  final int typeId = 6;

  @override
  _$APIKeyImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$APIKeyImpl(
      id: fields[0] as String,
      name: fields[1] as String,
      secret: fields[2] as String?,
      userId: fields[3] as String,
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$APIKeyImpl obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.secret)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is APIKeyImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$APIKeyImpl _$$APIKeyImplFromJson(Map<String, dynamic> json) => _$APIKeyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      secret: json['secret'] as String?,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$APIKeyImplToJson(_$APIKeyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'secret': instance.secret,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
