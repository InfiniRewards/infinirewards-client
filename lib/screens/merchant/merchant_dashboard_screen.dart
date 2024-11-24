import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinirewards/providers/merchant_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';

class MerchantDashboardScreen extends ConsumerStatefulWidget {
  const MerchantDashboardScreen({super.key});

  @override
  ConsumerState<MerchantDashboardScreen> createState() =>
      _MerchantDashboardScreenState();
}

class _MerchantDashboardScreenState
    extends ConsumerState<MerchantDashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(merchantNotifierProvider.notifier).fetchMerchantDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final merchantAsync = ref.watch(merchantNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: merchantAsync.when(
        data: (merchant) => merchant == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No merchant account found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => _showCreateMerchantDialog(context),
                      child: const Text('Create Merchant Account'),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: () => ref
                    .read(merchantNotifierProvider.notifier)
                    .fetchMerchantDetails(),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              merchant.name,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Address: ${merchant.address}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Symbol: ${merchant.symbol}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Decimals: ${merchant.decimals}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _ActionCard(
                          title: 'Points',
                          icon: Icons.wallet,
                          onTap: () => context.push('/merchant/points'),
                        ),
                        _ActionCard(
                          title: 'Vouchers',
                          icon: Icons.card_giftcard,
                          onTap: () => context.push('/merchant/vouchers'),
                        ),
                        _ActionCard(
                          title: 'Profile',
                          icon: Icons.person,
                          onTap: () => context.push('/merchant/profile'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load merchant details',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              TextButton(
                onPressed: () => ref
                    .read(merchantNotifierProvider.notifier)
                    .fetchMerchantDetails(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showCreateMerchantDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final symbolController = TextEditingController();
    final decimalsController = TextEditingController(text: '18');

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Merchant Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter merchant name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: symbolController,
              decoration: const InputDecoration(
                labelText: 'Points Symbol',
                hintText: 'Enter points symbol (e.g., PTS)',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: decimalsController,
              decoration: const InputDecoration(
                labelText: 'Decimals',
                hintText: 'Enter decimals for points',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                await ref
                    .read(merchantNotifierProvider.notifier)
                    .createMerchant(
                      name: nameController.text,
                      symbol: symbolController.text,
                      decimals: int.parse(decimalsController.text),
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } catch (e, stackTrace) {
                if (context.mounted) {
                  await showErrorDialog(
                    context,
                    message: e.toString(),
                    error: e,
                    stackTrace: stackTrace,
                  );
                }
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
