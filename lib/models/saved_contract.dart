import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'saved_contract.freezed.dart';
part 'saved_contract.g.dart';

@freezed
class SavedContract extends HiveObject with _$SavedContract {
  SavedContract._();

  @HiveType(typeId: 7)
  factory SavedContract({
    @HiveField(0) required String address,
    @HiveField(1) required String name,
    @HiveField(2) required String type, // 'points' or 'collectible'
    @HiveField(3) required DateTime addedAt,
  }) = _SavedContract;

  factory SavedContract.fromJson(Map<String, dynamic> json) => _$SavedContractFromJson(json);
} 