import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/providers/points_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';
import 'package:infinirewards/utils/share_points_dialog.dart';

class MerchantPointsScreen extends ConsumerWidget {
  const MerchantPointsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsAsync = ref.watch(pointsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Points Management'),
      ),
      body: pointsAsync.when(
        data: (points) => points.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No points contracts created',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => _showCreatePointsDialog(context, ref),
                      child: const Text('Create Points Contract'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: points.length,
                itemBuilder: (context, index) {
                  final contract = points[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  contract.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () => SharePointsDialog.show(
                                  context,
                                  contractAddress: contract.address,
                                  name: contract.name,
                                  symbol: contract.symbol,
                                  description: contract.description,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.upgrade),
                                onPressed: () => _showUpgradeDialog(
                                  context,
                                  ref,
                                  contract.address,
                                  contract.name,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Symbol: ${contract.symbol}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Decimals: ${contract.decimals}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Total Supply: ${contract.totalSupply}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FilledButton.icon(
                                onPressed: () => _showMintDialog(
                                  context,
                                  ref,
                                  contract.address,
                                ).then(
                                    (_) => ref.refresh(pointsNotifierProvider)),
                                icon: const Icon(Icons.add),
                                label: const Text('Mint'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load points contracts',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              TextButton(
                onPressed: () => ref.refresh(pointsNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: pointsAsync.whenOrNull(
        data: (points) => FloatingActionButton(
          onPressed: () => _showCreatePointsDialog(context, ref),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showCreatePointsDialog(
      BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final symbolController = TextEditingController();
    final descriptionController = TextEditingController();
    final decimalsController = TextEditingController(text: '18');

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Points Contract'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter points name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: symbolController,
                decoration: const InputDecoration(
                  labelText: 'Symbol',
                  hintText: 'Enter points symbol (e.g., PTS)',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter points description',
                ),
                maxLines: 2,
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
                    .read(pointsNotifierProvider.notifier)
                    .createPointsContract(
                      name: nameController.text,
                      symbol: symbolController.text,
                      description: descriptionController.text,
                      decimals: decimalsController.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Points contract created')),
                  );
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

  Future<void> _showMintDialog(
    BuildContext context,
    WidgetRef ref,
    String contractAddress,
  ) async {
    final recipientController = TextEditingController();
    final amountController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mint Points'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: recipientController,
              decoration: const InputDecoration(
                labelText: 'Recipient Address',
                hintText: 'Enter recipient address',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter amount to mint',
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
                await ref.read(pointsNotifierProvider.notifier).mint(
                      pointsContract: contractAddress,
                      recipient: recipientController.text,
                      amount: amountController.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Points minted successfully')),
                  );
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
            child: const Text('Mint'),
          ),
        ],
      ),
    );
  }

  void _showUpgradeDialog(
    BuildContext context,
    WidgetRef ref,
    String pointsContract,
    String pointsName,
  ) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upgrade Points: $pointsName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'New Class Hash',
                hintText: 'Enter the new implementation class hash',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ref
                    .read(pointsNotifierProvider.notifier)
                    .upgradePointsContract(
                      pointsContract: pointsContract,
                      newClassHash: controller.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Points $pointsName upgraded successfully'),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to upgrade points $pointsName: $e'),
                    ),
                  );
                }
              }
            },
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }
}
