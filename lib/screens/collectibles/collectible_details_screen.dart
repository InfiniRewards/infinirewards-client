import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/providers/collectibles_provider.dart';

class CollectibleDetailsScreen extends ConsumerWidget {
  final String id;

  const CollectibleDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectiblesAsync = ref.watch(collectiblesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collectible Details'),
      ),
      body: collectiblesAsync.when(
        data: (collectibles) {
          final collectible = collectibles.firstWhere(
            (c) => c.address == id,
            orElse: () => throw Exception('Collectible not found'),
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        collectible.isMembership
                            ? collectible.formattedName
                            : collectible.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        collectible.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Contract Address',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        collectible.address,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Points Contract',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        collectible.pointsContract,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              if (collectible.tokenIds.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  'Token Types',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ...List.generate(
                  collectible.tokenIds.length,
                  (index) => Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type ${collectible.tokenIds[index]}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            collectible.tokenDescriptions[index],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Price: ${collectible.tokenPrices[index]} points',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Expires in: ${collectible.tokenExpiries[index]} days',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Total supply: ${collectible.tokenSupplies?[index]}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load collectible details',
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
}
