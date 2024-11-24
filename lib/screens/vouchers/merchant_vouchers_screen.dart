import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/providers/collectibles_provider.dart';
import 'package:infinirewards/providers/merchant_provider.dart';
import 'package:infinirewards/providers/points_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';
import 'package:infinirewards/utils/collectible_dialogs.dart';
import 'package:infinirewards/utils/share_token_dialog.dart';

class MerchantVouchersScreen extends ConsumerWidget {
  const MerchantVouchersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vouchersAsync = ref.watch(collectiblesNotifierProvider);
    final pointsAsync = ref.watch(pointsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vouchers Management'),
      ),
      body: vouchersAsync.when(
        data: (vouchers) {
          final voucherContracts =
              vouchers.where((v) => !v.isMembership).toList();

          return voucherContracts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No vouchers created',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => _showCreateVoucherDialog(context, ref),
                        child: const Text('Create Voucher Contract'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () =>
                      ref.read(collectiblesNotifierProvider.notifier).refresh(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: voucherContracts.length,
                    itemBuilder: (context, index) {
                      final voucher = voucherContracts[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      voucher.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.upgrade),
                                    onPressed: () => _showUpgradeDialog(
                                      context,
                                      ref,
                                      voucher.address,
                                      voucher.name,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                voucher.description,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Token Types',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              ...List.generate(
                                voucher.tokenIds.length,
                                (i) => ListTile(
                                  title: Text(voucher.tokenDescriptions[i]),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Price: ${voucher.tokenPrices[i]} points'),
                                      Text(
                                          'Supply: ${voucher.tokenSupplies?[i] ?? 'Unlimited'}'),
                                      Text(
                                          'Expires in: ${voucher.tokenExpiries[i]} days'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.share),
                                        onPressed: () => ShareTokenDialog.show(
                                          context,
                                          contractAddress: voucher.address,
                                          tokenId: voucher.tokenIds[i],
                                          description:
                                              voucher.tokenDescriptions[i],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => CollectibleDialogs
                                            .showEditTokenDialog(
                                          context,
                                          ref,
                                          voucher.address,
                                          voucher.tokenIds[i],
                                          voucher.tokenDescriptions[i],
                                          voucher.tokenExpiries[i],
                                          int.tryParse(
                                                  voucher.tokenPrices[i]) ??
                                              0,
                                          pointsAsync.value
                                                  ?.map((p) => p.address)
                                                  .toList() ??
                                              [],
                                        ).then((_) => ref
                                            .read(collectiblesNotifierProvider
                                                .notifier)
                                            .refresh()),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.add_circle_outline),
                                        onPressed: () => CollectibleDialogs
                                            .showMintTokenDialog(
                                          context,
                                          ref,
                                          voucher.address,
                                          voucher.tokenIds[i],
                                        ).then((_) => ref
                                            .read(collectiblesNotifierProvider
                                                .notifier)
                                            .refresh()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FilledButton.icon(
                                    onPressed: () =>
                                        CollectibleDialogs.showAddTokenDialog(
                                      context,
                                      ref,
                                      voucher.address,
                                      voucher.tokenIds.length.toString(),
                                      pointsAsync.value
                                              ?.map((p) => p.address)
                                              .toList() ??
                                          [],
                                    ).then((_) => ref
                                            .read(collectiblesNotifierProvider
                                                .notifier)
                                            .refresh()),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add Token Type'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
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
      floatingActionButton: vouchersAsync.whenOrNull(
        data: (vouchers) => FloatingActionButton(
          onPressed: () => _showCreateVoucherDialog(context, ref),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showCreateVoucherDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Voucher Contract'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter voucher name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter voucher description',
              ),
              maxLines: 2,
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
                    .read(collectiblesNotifierProvider.notifier)
                    .createCollectible(
                      name: nameController.text,
                      description: descriptionController.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Voucher contract created')),
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

  void _showUpgradeDialog(
    BuildContext context,
    WidgetRef ref,
    String collectibleAddress,
    String voucherName,
  ) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upgrade Voucher: $voucherName'),
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
                    .read(merchantNotifierProvider.notifier)
                    .upgradeCollectibleContract(
                      collectibleAddress: collectibleAddress,
                      newClassHash: controller.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Voucher $voucherName upgraded successfully'),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Failed to upgrade voucher $voucherName: $e'),
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
