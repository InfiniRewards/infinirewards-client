import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/providers/app_state.dart';
import 'package:infinirewards/utils/error_dialog.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _isRetrying = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      setState(() {
        _hasError = false;
        _isRetrying = true;
      });

      // Add a timeout to prevent infinite loading
      await Future.wait([
        ref.read(appStateProvider.notifier).tryAutoLogin(),
        // Add minimum splash screen duration
        Future.delayed(const Duration(seconds: 2)),
      ]);
    } catch (e, stackTrace) {
      // Only show error if mounted and not already showing error
      if (mounted && !_hasError) {
        setState(() => _hasError = true);
        await showErrorDialog(
          context,
          message: e.toString(),
          error: e,
          stackTrace: stackTrace,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isRetrying = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer,
              ),
              child: Icon(
                Icons.card_giftcard_rounded,
                size: 64,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            if (_isRetrying)
              const CircularProgressIndicator()
            else if (_hasError)
              FilledButton(
                onPressed: _initialize,
                child: const Text('Retry'),
              )
            else
              const SizedBox(height: 20), // Maintain layout
            const SizedBox(height: 24),
            Text(
              'InfiniRewards',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Web3 Loyalty Platform',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            if (_isRetrying) ...[
              const SizedBox(height: 24),
              Text(
                'Retrying...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
