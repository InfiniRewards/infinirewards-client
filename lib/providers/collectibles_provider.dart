import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinirewards/env.dart';
import 'package:infinirewards/models/collectible_contract.dart';
import 'package:infinirewards/models/saved_contract.dart';
import 'package:infinirewards/providers/app_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';

part 'collectibles_provider.g.dart';

class CollectiblesException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  CollectiblesException(this.message, {this.code, this.originalError});

  @override
  String toString() {
    if (originalError != null) {
      return '$message\nOriginal error: $originalError';
    }
    return message;
  }
}

@riverpod
class CollectiblesNotifier extends _$CollectiblesNotifier {
  String get _baseUrl => InfinirewardsEnvironment.apiBaseUrl;
  Box<SavedContract>? _savedContractsBox;

  @override
  FutureOr<List<CollectibleContract>> build() async {
    _savedContractsBox ??= await Hive.openBox<SavedContract>('savedContracts');

    if (ref.read(appStateProvider).isMerchant) {
      return _fetchMerchantCollectibles();
    } else {
      return _fetchSavedCollectibles();
    }
  }

  Future<List<CollectibleContract>> _fetchMerchantCollectibles() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/merchant/collectible-contracts'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw CollectiblesException(
          data['message'] ?? 'Failed to fetch collectible contracts',
          code: data['code'],
        );
      }

      final contracts = (data['contracts'] as List)
          .map((contract) => CollectibleContract.fromJson(contract))
          .toList();

      return contracts;
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Network error occurred');
    }
  }

  Future<List<CollectibleContract>> _fetchSavedCollectibles() async {
    final savedContracts = _savedContractsBox!.values
        .where((contract) => contract.type == 'collectible')
        .toList();

    final contracts = <CollectibleContract>[];

    for (final saved in savedContracts) {
      try {
        final contract = await _fetchCollectibleDetails(saved.address);
        contracts.add(contract);
      } catch (e) {
        // Skip invalid contracts
        print('Failed to fetch contract ${saved.address}: $e');
      }
    }

    return contracts;
  }

  Future<CollectibleContract> _fetchCollectibleDetails(String address) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/collectibles/$address'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw CollectiblesException(
          data['message'] ?? 'Failed to fetch collectible details',
          code: data['code'],
        );
      }

      return CollectibleContract.fromJson(data);
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Network error occurred', originalError: e);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final contracts = ref.read(appStateProvider).isMerchant
          ? await _fetchMerchantCollectibles()
          : await _fetchSavedCollectibles();
      state = AsyncValue.data(contracts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addContract(String address) async {
    try {
      // Verify contract exists and get details
      final contract = await _fetchCollectibleDetails(address);

      // Save to local storage
      await _savedContractsBox!.add(SavedContract(
        address: address,
        name: contract.name,
        type: 'collectible',
        addedAt: DateTime.now(),
      ));

      // Refresh the list
      state = AsyncValue.data([...state.value ?? [], contract]);
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Failed to add contract', originalError: e);
    }
  }

  Future<void> removeContract(String address) async {
    try {
      // Remove from local storage
      final contractToRemove = _savedContractsBox!.values.firstWhere(
          (contract) =>
              contract.address == address && contract.type == 'collectible');
      await contractToRemove.delete();

      // Update state
      if (state.value != null) {
        state = AsyncValue.data(
          state.value!
              .where((contract) => contract.address != address)
              .toList(),
        );
      }
    } catch (e) {
      throw CollectiblesException('Failed to remove contract',
          originalError: e);
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
        throw CollectiblesException(
          data['message'] ?? 'Failed to create collectible',
          code: data['code'],
        );
      }

      await refresh();
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Network error occurred', originalError: e);
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
        throw CollectiblesException(
          data['message'] ?? 'Failed to set token data',
          code: data['code'],
        );
      }
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Network error occurred', originalError: e);
    }
  }

  Future<String> getBalance({
    required String address,
    required String tokenId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/collectibles/$address/balance/$tokenId'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw CollectiblesException(
          data['message'] ?? 'Failed to get balance',
          code: data['code'],
        );
      }

      return data['balance'];
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Network error occurred', originalError: e);
    }
  }

  Future<bool> isValid({
    required String address,
    required String tokenId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/collectibles/$address/valid/$tokenId'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw CollectiblesException(
          data['message'] ?? 'Failed to check validity',
          code: data['code'],
        );
      }

      return data['isValid'];
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Network error occurred', originalError: e);
    }
  }

  Future<void> purchase({
    required String address,
    required String tokenId,
    required String amount,
    required String user,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/collectibles/$address/purchase'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'tokenId': tokenId,
          'amount': amount,
          'user': user,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw CollectiblesException(
          data['message'] ?? 'Purchase failed',
          code: data['code'],
        );
      }
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Network error occurred', originalError: e);
    }
  }

  Future<void> redeem({
    required String address,
    required String tokenId,
    required String amount,
    required String user,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/collectibles/$address/redeem'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'tokenId': tokenId,
          'amount': amount,
          'user': user,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw CollectiblesException(
          data['message'] ?? 'Redemption failed',
          code: data['code'],
        );
      }
    } catch (e) {
      if (e is CollectiblesException) rethrow;
      throw CollectiblesException('Network error occurred', originalError: e);
    }
  }
}
