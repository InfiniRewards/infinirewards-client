import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinirewards/models/collectible_contract.dart';
import 'package:infinirewards/providers/collectibles_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';

class VouchersScreen extends ConsumerWidget {
  const VouchersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vouchersAsync = ref.watch(collectiblesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vouchers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddVoucherDialog(context, ref),
          ),
        ],
      ),
      body: vouchersAsync.when(
        data: (vouchers) => vouchers.isEmpty
            ? Center(
                child: Text(
                  'No vouchers available',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  return VoucherCard(contract: vouchers[index]);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load vouchers',
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
    );
  }

  Future<void> _showAddVoucherDialog(
      BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Voucher Contract'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Contract Address',
            hintText: 'Enter voucher contract address',
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
                    .read(collectiblesNotifierProvider.notifier)
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

class VoucherCard extends ConsumerWidget {
  final CollectibleContract contract;

  const VoucherCard({
    super.key,
    required this.contract,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/vouchers/details/${contract.address}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contract.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          contract.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      try {
                        await ref
                            .read(collectiblesNotifierProvider.notifier)
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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${contract.tokenIds.length} voucher types',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
