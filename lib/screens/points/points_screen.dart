import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinirewards/models/points_contract.dart';
import 'package:infinirewards/providers/points_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';
import 'package:infinirewards/utils/share_points_dialog.dart';

class PointsScreen extends ConsumerWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsAsync = ref.watch(pointsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Points'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPointsDialog(context, ref),
          ),
        ],
      ),
      body: pointsAsync.when(
        data: (points) => points.isEmpty
            ? Center(
                child: Text(
                  'No points contracts added yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            : ListView.builder(
                itemCount: points.length,
                itemBuilder: (context, index) {
                  return PointsContractCard(contract: points[index]);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load points',
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/transfer'),
        label: const Text('Transfer'),
        icon: const Icon(Icons.send),
      ),
    );
  }

  Future<void> _showAddPointsDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Points Contract'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Contract Address',
            hintText: 'Enter points contract address',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.isEmpty) {
                await showErrorDialog(
                  context,
                  message: 'Please enter a contract address',
                );
                return;
              }
              try {
                await ref
                    .read(pointsNotifierProvider.notifier)
                    .addContract(controller.text);
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
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class PointsContractCard extends ConsumerWidget {
  final PointsContract contract;

  const PointsContractCard({
    super.key,
    required this.contract,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    try {
                      await ref
                          .read(pointsNotifierProvider.notifier)
                          .removeContract(contract.address);
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
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (contract.description.isNotEmpty) ...[
              Text(
                contract.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
            ],
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Balance',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        contract.balance ?? '0',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Symbol',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        contract.symbol,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
