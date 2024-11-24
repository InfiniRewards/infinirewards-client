import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/providers/collectibles_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';

class MembershipsScreen extends ConsumerWidget {
  const MembershipsScreen({super.key});

  Future<void> _showImportMembershipDialog(
      BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Membership'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Contract Address',
            hintText: 'Enter membership contract address',
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
                    .read(collectiblesNotifierProvider.notifier)
                    .addContract(controller.text);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Membership imported successfully'),
                    ),
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
            child: const Text('Import'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipsAsync = ref.watch(collectiblesNotifierProvider);

    return Scaffold(
      body: membershipsAsync.when(
        data: (collectibles) {
          final memberships =
              collectibles.where((c) => c.type == 'membership').toList();

          if (memberships.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No memberships found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _showImportMembershipDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Import Membership'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: memberships.length,
            itemBuilder: (context, index) {
              final membership = memberships[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.card_membership),
                  title: Text(membership.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(membership.description),
                      const SizedBox(height: 4),
                      Text(
                        'Contract: ${membership.address}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load memberships',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              TextButton(
                onPressed: () => ref.refresh(collectiblesNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showImportMembershipDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
