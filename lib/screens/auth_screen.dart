import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/providers/app_state.dart';
import 'package:infinirewards/utils/error_dialog.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  String? _verificationId;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    print('initState');
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    print('dispose');
    super.dispose();
  }

  Future<void> _requestOTP() async {
    if (_phoneController.text.isEmpty) {
      await showErrorDialog(
        context,
        message: 'Please enter your phone number',
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await ref.read(appStateProvider.notifier).requestOTP(
            phone: _phoneController.text,
          );
      setState(() {
        _verificationId = response['id'];
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        await showErrorDialog(
          context,
          message: e.toString(),
          error: e,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.isEmpty) {
      await showErrorDialog(
        context,
        message: 'Please enter the OTP',
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await ref.read(appStateProvider.notifier).authenticate(
            _verificationId!,
            _otpController.text,
            'otp',
          );
    } catch (e, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        await showErrorDialog(
          context,
          message: e.toString(),
          error: e,
          stackTrace: stackTrace,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: size.height * 0.08),
                    // Logo and App Name
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.primaryContainer,
                            ),
                            child: Icon(
                              Icons.card_giftcard_rounded,
                              size: 48,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'InfiniRewards',
                            style: textTheme.headlineMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your Web3 Loyalty Platform',
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    // Error Message
                    if (_error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _error!,
                          style: TextStyle(color: colorScheme.error),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 24),
                    // Phone Number or OTP Input
                    if (_verificationId == null) ...[
                      Text(
                        'Enter your phone number',
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: '+60123456789',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                        ),
                        keyboardType: TextInputType.phone,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: _isLoading ? null : _requestOTP,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Request OTP'),
                      ),
                    ] else ...[
                      Text(
                        'Enter verification code',
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We sent a code to ${_phoneController.text}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          labelText: 'OTP Code',
                          hintText: '123456',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                        ),
                        keyboardType: TextInputType.number,
                        enabled: !_isLoading,
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: _isLoading ? null : _verifyOTP,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Verify'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                setState(() {
                                  _verificationId = null;
                                  _otpController.clear();
                                  _error = null;
                                });
                              },
                        child: const Text('Change Phone Number'),
                      ),
                    ],
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(),
                    ),
                    // Terms and Privacy
                    Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
