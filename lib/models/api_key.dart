import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'api_key.freezed.dart';
part 'api_key.g.dart';

@freezed
class APIKey extends HiveObject with _$APIKey {
  APIKey._();

  @HiveType(typeId: 6)
  factory APIKey({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) String? secret,
    @HiveField(3) required String userId,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) required DateTime updatedAt,
  }) = _APIKey;

  factory APIKey.fromJson(Map<String, dynamic> json) => _$APIKeyFromJson(json);
} 