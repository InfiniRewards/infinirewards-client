import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:infinirewards/env.dart';
import 'package:infinirewards/models/app_state.dart';
import 'package:infinirewards/models/token.dart';
import 'package:infinirewards/providers/merchant_provider.dart';
import 'package:infinirewards/providers/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state.g.dart';

const baseUrl = InfinirewardsEnvironment.apiBaseUrl;

class AuthException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AuthException(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  String toString() {
    if (originalError != null) {
      return '$message\nOriginal error: $originalError';
    }
    return message;
  }
}

@Riverpod(keepAlive: true)
class AppState extends _$AppState {
  Box<AppStateData>? _hiveBox;
  Timer? _refreshTokenTimer;
  bool _isAutoLoggingIn = false;

  @override
  AppStateData build() {
    _hiveBox ??= Hive.box<AppStateData>("appState");
    final result = _hiveBox!.get("appState", defaultValue: AppStateData())!;
    return result.copyWith(autoLoginResult: null);
  }

  void changeNavigatorIndex(int newIndex) {
    state = state.copyWith(navigatorIndex: newIndex);
    _hiveBox!.put("appState", state);
  }

  void changeTheme(String theme) {
    state = state.copyWith(theme: theme);
    _hiveBox!.put("appState", state);
  }

  Future<void> authenticate(String id, String token, String method) async {
    try {
      final deviceId = 'device_${DateTime.now().millisecondsSinceEpoch}';

      final response = await http.post(
        Uri.parse('$baseUrl/auth/authenticate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'token': token,
          'method': method,
          'device': deviceId,
          'signature': 'device_signature_$deviceId',
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw AuthException(
          data['message'] ?? 'Authentication failed',
          code: data['code'],
          originalError: data,
        );
      }

      final authToken = Token.fromJson(data['token']);

      _setupRefreshTimer(authToken);

      state = state.copyWith(token: authToken, autoLoginResult: true);
      await _hiveBox!.put("appState", state);

      // Fetch user details after successful authentication
      await ref.read(userNotifierProvider.notifier).fetchUserDetails();
      await ref.read(merchantNotifierProvider.notifier).fetchMerchantDetails();
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(
        'Network error occurred',
        originalError: e,
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(
      navigatorIndex: 0,
      token: null,
      autoLoginResult: null,
    );
    _refreshTokenTimer?.cancel();
    _refreshTokenTimer = null;
    await _hiveBox!.put("appState", state);
  }

  Future<void> tryAutoLogin() async {
    if (_isAutoLoggingIn) return;
    _isAutoLoggingIn = true;
    if (state.token == null) {
      return;
    }
    try {
      await refreshToken();
      // Fetch user details after successful token refresh
      await ref.read(userNotifierProvider.notifier).fetchUserDetails();
      await ref.read(merchantNotifierProvider.notifier).fetchMerchantDetails();
      state = state.copyWith(autoLoginResult: true);
      return;
    } catch (e) {
      await logout();
      return;
    } finally {
      _isAutoLoggingIn = false;
    }
  }

  Future<void> refreshToken() async {
    if (state.token == null) return;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh-token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': state.bearerToken,
        },
        body: json.encode({
          'refreshToken': state.token!.id,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw AuthException(
          data['message'] ?? 'Token refresh failed',
          code: data['code'],
          originalError: data,
        );
      }

      final newToken = Token.fromJson(data['token']);

      _setupRefreshTimer(newToken);

      state = state.copyWith(token: newToken);
      await _hiveBox!.put("appState", state);
    } catch (e) {
      await logout();
      if (e is AuthException) rethrow;
      throw AuthException(
        'Network error occurred',
        originalError: e,
      );
    }
  }

  void _setupRefreshTimer(Token token) {
    _refreshTokenTimer?.cancel();
    final difference = token.accessTokenExpiry.difference(DateTime.now());
    if (difference.isNegative) return;

    _refreshTokenTimer = Timer(difference, refreshToken);
  }

  Future<Map<String, dynamic>> requestOTP({required String phone}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/request-otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phoneNumber': phone,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw AuthException(
          data['message'] ?? 'Failed to request OTP',
          code: data['code'],
          originalError: data,
        );
      }

      return data;
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(
        'Network error occurred',
        originalError: e,
      );
    }
  }

  void toggleMerchantMode(bool value) {
    state = state.copyWith(isMerchant: value);
  }
}
