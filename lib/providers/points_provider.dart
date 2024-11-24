import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinirewards/env.dart';
import 'package:infinirewards/models/points_contract.dart';
import 'package:infinirewards/providers/app_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';
import 'package:infinirewards/models/saved_contract.dart';

part 'points_provider.g.dart';

class PointsException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  PointsException(this.message, {this.code, this.originalError});

  @override
  String toString() {
    if (originalError != null) {
      return '$message\nOriginal error: $originalError';
    }
    return message;
  }
}

@riverpod
class PointsNotifier extends _$PointsNotifier {
  String get _baseUrl => InfinirewardsEnvironment.apiBaseUrl;
  Box<SavedContract>? _savedContractsBox;

  @override
  FutureOr<List<PointsContract>> build() async {
    _savedContractsBox ??= await Hive.openBox<SavedContract>('savedContracts');

    if (ref.read(appStateProvider).isMerchant) {
      return _fetchMerchantPointsContracts();
    } else {
      return _fetchSavedPointsContracts();
    }
  }

  Future<List<PointsContract>> _fetchMerchantPointsContracts() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/merchant/points-contracts'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw PointsException(
          data['message'] ?? 'Failed to fetch points contracts',
          code: data['code'],
        );
      }

      final contracts = (data['contracts'] as List)
          .map((contract) => PointsContract.fromJson(contract))
          .toList();

      return contracts;
    } catch (e) {
      if (e is PointsException) rethrow;
      throw PointsException('Network error occurred', originalError: e);
    }
  }

  Future<List<PointsContract>> _fetchSavedPointsContracts() async {
    final savedContracts = _savedContractsBox!.values
        .where((contract) => contract.type == 'points')
        .toList();

    final contracts = <PointsContract>[];

    for (final saved in savedContracts) {
      try {
        final contract = await _fetchPointsContractDetails(saved.address);
        contracts.add(contract);
      } catch (e) {
        // Skip invalid contracts
        print('Failed to fetch contract ${saved.address}: $e');
      }
    }

    return contracts;
  }

  Future<PointsContract> _fetchPointsContractDetails(String address) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/points/$address/balance'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw PointsException(
          data['message'] ?? 'Failed to fetch points contract details',
          code: data['code'],
        );
      }

      return PointsContract(
        address: address,
        name: data['name'],
        symbol: data['symbol'],
        decimals: data['decimals'],
        description: data['description'],
        totalSupply: 0, // Not included in balance response
        balance: data['balance'],
      );
    } catch (e) {
      if (e is PointsException) rethrow;
      throw PointsException('Network error occurred', originalError: e);
    }
  }

  // Future<PointsContract> getBalance(String address) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$_baseUrl/points/$address/balance'),
  //       headers: {
  //         'Authorization': ref.read(appStateProvider).bearerToken,
  //       },
  //     );

  //     final data = json.decode(response.body);

  //     if (response.statusCode != 200) {
  //       throw PointsException(
  //         data['message'] ?? 'Failed to get balance',
  //         code: data['code'],
  //       );
  //     }

  //     return PointsContract(
  //       address: address,
  //       name: data['name'],
  //       symbol: data['symbol'],
  //       decimals: data['decimals'],
  //       description: data['description'],
  //       totalSupply: 0, // Not included in balance response
  //       balance: data['balance'],
  //     );
  //   } catch (e) {
  //     if (e is PointsException) rethrow;
  //     throw PointsException('Network error occurred', originalError: e);
  //   }
  // }

  Future<void> addContract(String address) async {
    try {
      // Verify contract exists and get details
      final contract = await _fetchPointsContractDetails(address);

      // Save to local storage
      await _savedContractsBox!.add(SavedContract(
        address: address,
        name: contract.name,
        type: 'points',
        addedAt: DateTime.now(),
      ));

      // Refresh the list
      state = AsyncValue.data([...state.value ?? [], contract]);
    } catch (e) {
      if (e is PointsException) rethrow;
      throw PointsException('Failed to add contract', originalError: e);
    }
  }

  Future<void> removeContract(String address) async {
    try {
      // Remove from local storage
      final contractToRemove = _savedContractsBox!.values.firstWhere(
          (contract) =>
              contract.address == address && contract.type == 'points');
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
      throw PointsException('Failed to remove contract', originalError: e);
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
        throw PointsException(
          data['message'] ?? 'Failed to create points contract',
          code: data['code'],
        );
      }

      // Refresh the list of contracts
      state = AsyncValue.data(
          [...state.value ?? [], PointsContract.fromJson(data)]);
    } catch (e) {
      if (e is PointsException) rethrow;
      throw PointsException('Network error occurred', originalError: e);
    }
  }

  Future<void> transfer({
    required String pointsContract,
    required String to,
    required String amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/points/transfer'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'pointsContract': pointsContract,
          'to': to,
          'amount': amount,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw PointsException(
          data['message'] ?? 'Transfer failed',
          code: data['code'],
        );
      }
    } catch (e) {
      if (e is PointsException) rethrow;
      throw PointsException('Network error occurred', originalError: e);
    }
  }

  Future<void> mint({
    required String pointsContract,
    required String recipient,
    required String amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/points/mint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'pointsContract': pointsContract,
          'recipient': recipient,
          'amount': amount,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw PointsException(
          data['message'] ?? 'Mint failed',
          code: data['code'],
        );
      }
    } catch (e) {
      if (e is PointsException) rethrow;
      throw PointsException('Network error occurred', originalError: e);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final contracts = await _fetchMerchantPointsContracts();
      state = AsyncValue.data(contracts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> upgradePointsContract({
    required String pointsContract,
    required String newClassHash,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/points/upgrade'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'pointsContract': pointsContract,
          'newClassHash': newClassHash,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw PointsException(
          data['message'] ?? 'Failed to upgrade points contract',
          code: data['code'],
        );
      }

      // Refresh the list after successful upgrade
      await refresh();
    } catch (e) {
      if (e is PointsException) rethrow;
      throw PointsException('Network error occurred', originalError: e);
    }
  }
}
