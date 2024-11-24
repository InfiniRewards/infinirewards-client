import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User extends HiveObject with _$User {
  User._();

  @HiveType(typeId: 2)
  factory User({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String email,
    @HiveField(3) required String phoneNumber,
    @HiveField(4) String? avatar,
    @HiveField(5) required String accountAddress,
    @HiveField(6) required String publicKey,
    @HiveField(7) required String privateKey,
    @HiveField(8) required DateTime createdAt,
    @HiveField(9) required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
