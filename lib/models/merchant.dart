import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'merchant.freezed.dart';
part 'merchant.g.dart';

@freezed
class Merchant extends HiveObject with _$Merchant {
  Merchant._();

  @HiveType(typeId: 3)
  factory Merchant({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String address,
    @HiveField(3) required int decimals,
    @HiveField(4) required String symbol,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) required DateTime updatedAt,
  }) = _Merchant;

  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);
}
