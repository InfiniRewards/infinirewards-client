import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinirewards/env.dart';
import 'package:infinirewards/models/merchant.dart';
import 'package:infinirewards/providers/app_state.dart';
import 'package:infinirewards/providers/collectibles_provider.dart';
import 'package:infinirewards/providers/points_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_provider.g.dart';

class MerchantException implements Exception {
  final String message;
  final dynamic originalError;
  final String? code;
  MerchantException(this.message, {this.originalError, this.code});

  @override
  String toString() {
    if (originalError != null) {
      return '$message\nOriginal error: $originalError';
    }
    return message;
  }
}

@Riverpod(keepAlive: true)
class MerchantNotifier extends _$MerchantNotifier {
  String get _baseUrl => InfinirewardsEnvironment.apiBaseUrl;

  @override
  FutureOr<Merchant?> build() async {
    // Initially return null, merchant details will be fetched when needed
    return null;
  }

  Future<void> createMerchant({
    required String name,
    required int decimals,
    required String symbol,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/merchant'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'name': name,
          'decimals': decimals,
          'symbol': symbol,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 201) {
        throw MerchantException(
          data['message'] ?? 'Failed to create merchant',
          code: data['code'],
        );
      }

      await fetchMerchantDetails();
    } catch (e) {
      if (e is MerchantException) rethrow;
      throw MerchantException('Network error occurred', originalError: e);
    }
  }

  Future<void> fetchMerchantDetails() async {
    try {
      state = const AsyncValue.loading();

      final response = await http.get(
        Uri.parse('$_baseUrl/merchant'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 404) {
        state = const AsyncValue.data(null);
        return;
      }

      if (response.statusCode != 200) {
        throw MerchantException(
          data['message'] ?? 'Failed to fetch merchant details',
          code: data['code'],
        );
      }

      state = AsyncValue.data(Merchant.fromJson(data));
    } catch (e) {
      state = AsyncValue.error(
        e is MerchantException
            ? e
            : MerchantException('Network error occurred'),
        StackTrace.current,
      );
    }
  }

  Future<void> createPointsContract({
    required String name,
    required String symbol,
    required String description,
    required String decimals,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/merchant/points'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'name': name,
          'symbol': symbol,
          'description': description,
          'decimals': decimals,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 201) {
        throw MerchantException(
          data['message'] ?? 'Failed to create points contract',
          code: data['code'],
        );
      }

      // Refresh points contracts list
      await ref.read(pointsNotifierProvider.notifier).refresh();
    } catch (e) {
      if (e is MerchantException) rethrow;
      throw MerchantException('Network error occurred', originalError: e);
    }
  }

  Future<void> createCollectible({
    required String name,
    required String description,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/merchant/collectibles'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'name': name,
          'description': description,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 201) {
        throw MerchantException(
          data['message'] ?? 'Failed to create collectible',
          code: data['code'],
        );
      }

      // Refresh collectibles list
      await ref.read(collectiblesNotifierProvider.notifier).refresh();
    } catch (e) {
      if (e is MerchantException) rethrow;
      throw MerchantException('Network error occurred', originalError: e);
    }
  }

  Future<void> setTokenData({
    required String address,
    required String tokenId,
    required String description,
    required int expiry,
    required String pointsContract,
    required String price,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/collectibles/$address/token-data/$tokenId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'description': description,
          'expiry': expiry,
          'pointsContract': pointsContract,
          'price': price,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw MerchantException(
          data['message'] ?? 'Failed to set token data',
          code: data['code'],
        );
      }
    } catch (e) {
      if (e is MerchantException) rethrow;
      throw MerchantException('Network error occurred', originalError: e);
    }
  }

  Future<void> mintCollectible({
    required String address,
    required String tokenId,
    required String recipient,
    required int amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/merchant/collectibles/mint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'collectibleAddress': address,
          'to': recipient,
          'tokenId': tokenId,
          'amount': amount.toString(),
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw MerchantException(
          data['message'] ?? 'Failed to mint collectible',
          code: data['code'],
        );
      }

      // Refresh collectibles list
      await ref.read(collectiblesNotifierProvider.notifier).refresh();
    } catch (e) {
      if (e is MerchantException) rethrow;
      throw MerchantException('Network error occurred', originalError: e);
    }
  }

  Future<void> upgradeMerchantContract({
    required String newClassHash,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/merchant/upgrade'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'newClassHash': newClassHash,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw MerchantException(
          data['message'] ?? 'Failed to upgrade merchant contract',
          code: data['code'],
        );
      }

      // Refresh merchant details after successful upgrade
      await fetchMerchantDetails();
    } catch (e) {
      if (e is MerchantException) rethrow;
      throw MerchantException('Network error occurred', originalError: e);
    }
  }

  Future<void> upgradeCollectibleContract({
    required String collectibleAddress,
    required String newClassHash,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/merchant/collectible/upgrade'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'collectibleAddress': collectibleAddress,
          'newClassHash': newClassHash,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw MerchantException(
          data['message'] ?? 'Failed to upgrade collectible contract',
          code: data['code'],
        );
      }

      // Refresh collectibles list after successful upgrade
      await ref.read(collectiblesNotifierProvider.notifier).refresh();
    } catch (e) {
      if (e is MerchantException) rethrow;
      throw MerchantException('Network error occurred', originalError: e);
    }
  }
}
