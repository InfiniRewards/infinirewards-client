import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinirewards/env.dart';
import 'package:infinirewards/models/api_key.dart';
import 'package:infinirewards/models/user.dart';
import 'package:infinirewards/providers/app_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

class UserException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  UserException(this.message, {this.code, this.originalError});

  @override
  String toString() {
    if (originalError != null) {
      return '$message\nOriginal error: $originalError';
    }
    return message;
  }
}

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  String get _baseUrl => InfinirewardsEnvironment.apiBaseUrl;

  @override
  FutureOr<User?> build() async {
    // Initially return null, user details will be fetched when needed
    return null;
  }

  Future<void> fetchUserDetails() async {
    try {
      state = const AsyncValue.loading();

      final response = await http.get(
        Uri.parse('$_baseUrl/user'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw UserException(
          data['message'] ?? 'Failed to fetch user details',
          code: data['code'],
        );
      }

      state = AsyncValue.data(User.fromJson(data));
    } catch (e) {
      state = AsyncValue.error(
        e is UserException
            ? e
            : UserException('Network error occurred', originalError: e),
        StackTrace.current,
      );
    }
  }

  Future<void> updateUser({
    String? name,
    String? email,
    String? avatar,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          if (name != null) 'name': name,
          if (email != null) 'email': email,
          if (avatar != null) 'avatar': avatar,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw UserException(
          data['message'] ?? 'Failed to update user',
          code: data['code'],
        );
      }

      state = AsyncValue.data(User.fromJson(data));
    } catch (e) {
      if (e is UserException) rethrow;
      throw UserException('Network error occurred', originalError: e);
    }
  }

  Future<void> deleteUser() async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/user'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw UserException(
          data['message'] ?? 'Failed to delete user',
          code: data['code'],
        );
      }

      // Clear user data after successful deletion
      state = const AsyncValue.data(null);

      // Logout user
      await ref.read(appStateProvider.notifier).logout();
    } catch (e) {
      if (e is UserException) rethrow;
      throw UserException('Network error occurred', originalError: e);
    }
  }

  Future<void> createUser({
    required String name,
    required String email,
    String? avatar,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'name': name,
          'email': email,
          if (avatar != null) 'avatar': avatar,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 201) {
        throw UserException(
          data['message'] ?? 'Failed to create user',
          code: data['code'],
        );
      }

      state = AsyncValue.data(User.fromJson(data));
    } catch (e) {
      if (e is UserException) rethrow;
      throw UserException('Network error occurred', originalError: e);
    }
  }

  Future<List<APIKey>> getApiKeys() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user/api-keys'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw UserException(
          data['message'] ?? 'Failed to fetch API keys',
          code: data['code'],
        );
      }

      return (data as List).map((key) => APIKey.fromJson(key)).toList();
    } catch (e) {
      if (e is UserException) rethrow;
      throw UserException('Network error occurred', originalError: e);
    }
  }

  Future<APIKey> createApiKey(String name) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/user/api-keys'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
        body: json.encode({
          'name': name,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 201) {
        throw UserException(
          data['message'] ?? 'Failed to create API key',
          code: data['code'],
        );
      }

      return APIKey.fromJson(data);
    } catch (e) {
      if (e is UserException) rethrow;
      throw UserException('Network error occurred', originalError: e);
    }
  }

  Future<void> deleteApiKey(String keyId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/user/api-keys/$keyId'),
        headers: {
          'Authorization': ref.read(appStateProvider).bearerToken,
        },
      );

      if (response.statusCode != 200) {
        final data = json.decode(response.body);
        throw UserException(
          data['message'] ?? 'Failed to delete API key',
          code: data['code'],
        );
      }
    } catch (e) {
      if (e is UserException) rethrow;
      throw UserException('Network error occurred', originalError: e);
    }
  }

  Future<void> upgradeUserContract({
    required String newClassHash,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/user/upgrade'),
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
        throw UserException(
          data['message'] ?? 'Failed to upgrade user contract',
          code: data['code'],
        );
      }

      // Refresh user data after successful upgrade
      await fetchUserDetails();
    } catch (e) {
      if (e is UserException) rethrow;
      throw UserException('Network error occurred', originalError: e);
    }
  }
}
