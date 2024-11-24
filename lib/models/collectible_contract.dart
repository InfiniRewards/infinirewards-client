import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'collectible_contract.freezed.dart';
part 'collectible_contract.g.dart';

@freezed
class CollectibleContract extends HiveObject with _$CollectibleContract {
  CollectibleContract._();

  @HiveType(typeId: 5)
  factory CollectibleContract({
    @HiveField(0) required String address,
    @HiveField(1) required String name,
    @HiveField(2) required String description,
    @HiveField(3) required String pointsContract,
    @HiveField(4) required List<String> tokenIds,
    @HiveField(5) required List<String> tokenDescriptions,
    @HiveField(6) required List<String> tokenPrices,
    @HiveField(7) required List<int> tokenExpiries,
    @HiveField(8) required List<String>? tokenBalances,
    @HiveField(9) required List<String>? tokenSupplies,
  }) = _CollectibleContract;

  factory CollectibleContract.fromJson(Map<String, dynamic> json) =>
      _$CollectibleContractFromJson(json);

  bool get isMembership => name.toLowerCase().startsWith('[membership]');
  String get formattedName => name.replaceFirst('[membership]', '').trim();
  String get type => isMembership ? 'membership' : 'voucher';
}
