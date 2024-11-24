import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/providers/collectibles_provider.dart';
import 'package:infinirewards/providers/points_provider.dart';
import 'package:infinirewards/providers/merchant_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';
import 'package:infinirewards/utils/collectible_dialogs.dart';
import 'package:infinirewards/utils/share_token_dialog.dart';

class MerchantMembershipsScreen extends ConsumerWidget {
  const MerchantMembershipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectiblesAsync = ref.watch(collectiblesNotifierProvider);
    final pointsAsync = ref.watch(pointsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memberships Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upgrade),
            onPressed: () {
              // Only show upgrade dialog if there's a membership contract
              if (collectiblesAsync.value?.any((c) => c.isMembership) ??
                  false) {
                final membershipContract =
                    collectiblesAsync.value!.firstWhere((c) => c.isMembership);
                _showUpgradeDialog(context, ref, membershipContract.address);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('No membership contract to upgrade')),
                );
              }
            },
          ),
        ],
      ),
      body: collectiblesAsync.when(
        data: (collectibles) {
          final memberships =
              collectibles.where((c) => c.isMembership).toList();

          return memberships.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No membership program created',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () =>
                            _showCreateMembershipDialog(context, ref),
                        child: const Text('Create Membership Program'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () =>
                      ref.read(collectiblesNotifierProvider.notifier).refresh(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: memberships.length,
                    itemBuilder: (context, index) {
                      final membership = memberships[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                membership.formattedName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                membership.description,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Token Types',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              ...List.generate(
                                membership.tokenIds.length,
                                (i) => ListTile(
                                  title: Text(membership.tokenDescriptions[i]),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Price: ${membership.tokenPrices[i]} points'),
                                      Text(
                                          'Supply: ${membership.tokenSupplies?[i] ?? 'Unlimited'}'),
                                      Text(
                                          'Expires in: ${membership.tokenExpiries[i]} days'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.share),
                                        onPressed: () => ShareTokenDialog.show(
                                          context,
                                          contractAddress: membership.address,
                                          tokenId: membership.tokenIds[i],
                                          description:
                                              membership.tokenDescriptions[i],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => CollectibleDialogs
                                            .showEditTokenDialog(
                                          context,
                                          ref,
                                          membership.address,
                                          membership.tokenIds[i],
                                          membership.tokenDescriptions[i],
                                          membership.tokenExpiries[i],
                                          int.tryParse(
                                                  membership.tokenPrices[i]) ??
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
                                          membership.address,
                                          membership.tokenIds[i],
                                        ),
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
                                      membership.address,
                                      membership.tokenIds.length.toString(),
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
      floatingActionButton: collectiblesAsync.whenOrNull(
        data: (collectibles) => collectibles.any((c) => c.isMembership)
            ? null // Only allow one membership program
            : FloatingActionButton(
                onPressed: () => _showCreateMembershipDialog(context, ref),
                child: const Icon(Icons.add),
              ),
      ),
    );
  }

  void _showUpgradeDialog(
      BuildContext context, WidgetRef ref, String contractAddress) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upgrade Membership Contract'),
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
                      collectibleAddress: contractAddress,
                      newClassHash: controller.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Membership contract upgraded successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Failed to upgrade membership contract: $e')),
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

  Future<void> _showCreateMembershipDialog(
      BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Membership Program'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter membership program name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter membership program description',
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
                      name: '[membership] ${nameController.text}',
                      description: descriptionController.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Membership program created')),
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
}
