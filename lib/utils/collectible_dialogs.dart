import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/providers/merchant_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';
import 'package:infinirewards/utils/format_address.dart';

class CollectibleDialogs {
  static Future<void> showEditTokenDialog(
    BuildContext context,
    WidgetRef ref,
    String address,
    String tokenId,
    String tokenDescription,
    int tokenExpiry,
    int tokenPrice,
    List<String> points,
  ) {
    final descriptionController = TextEditingController(text: tokenDescription);
    final priceController = TextEditingController(text: tokenPrice.toString());
    final expiryController = TextEditingController(
      text: ((DateTime.fromMillisecondsSinceEpoch(tokenExpiry)
                  .difference(DateTime.now())
                  .inDays) +
              1)
          .toString(),
    );
    String? selectedPointsContract = points.isNotEmpty ? points.first : null;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Token Type'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter token description',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter price in points',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: expiryController,
                decoration: const InputDecoration(
                  labelText: 'Expiry (days)',
                  hintText: 'Enter expiry in days',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedPointsContract,
                decoration: const InputDecoration(
                  labelText: 'Points Contract',
                  hintText: 'Select points contract',
                ),
                items: points
                    .map((contract) => DropdownMenuItem(
                          value: contract,
                          child: Text(formatAddress(contract)),
                        ))
                    .toList(),
                onChanged: (value) => selectedPointsContract = value,
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
              if (selectedPointsContract == null) {
                await showErrorDialog(
                  context,
                  message: 'Please select a points contract',
                );
                return;
              }

              try {
                final expiry = int.tryParse(expiryController.text);
                if (expiry == null) {
                  throw Exception('Invalid expiry value');
                }

                final price = int.tryParse(priceController.text);
                if (price == null) {
                  throw Exception('Invalid price value');
                }

                final expiryDate = DateTime.now().add(Duration(days: expiry));

                await ref.read(merchantNotifierProvider.notifier).setTokenData(
                      address: address,
                      tokenId: tokenId,
                      description: descriptionController.text,
                      expiry: expiryDate.millisecondsSinceEpoch,
                      pointsContract: selectedPointsContract!,
                      price: price.toString(),
                    );

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Token updated successfully')),
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
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  static Future<void> showMintTokenDialog(
    BuildContext context,
    WidgetRef ref,
    String address,
    String tokenId,
  ) {
    final recipientController = TextEditingController();
    final amountController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mint Token'),
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
                final amount = int.tryParse(amountController.text);
                if (amount == null) {
                  throw Exception('Invalid amount value');
                }

                await ref
                    .read(merchantNotifierProvider.notifier)
                    .mintCollectible(
                      address: address,
                      tokenId: tokenId,
                      recipient: recipientController.text,
                      amount: amount,
                    );

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Token minted successfully')),
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

  static Future<void> showAddTokenDialog(
    BuildContext context,
    WidgetRef ref,
    String address,
    String tokenId,
    List<String> points,
  ) {
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final expiryController = TextEditingController();
    String? selectedPointsContract = points.isNotEmpty ? points.first : null;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Token Type'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter token description',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter price in points',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: expiryController,
                decoration: const InputDecoration(
                  labelText: 'Expiry (days)',
                  hintText: 'Enter expiry in days',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedPointsContract,
                decoration: const InputDecoration(
                  labelText: 'Points Contract',
                  hintText: 'Select points contract',
                ),
                items: points
                    .map((contract) => DropdownMenuItem(
                          value: contract,
                          child: Text(formatAddress(contract)),
                        ))
                    .toList(),
                onChanged: (value) => selectedPointsContract = value,
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
              if (selectedPointsContract == null) {
                await showErrorDialog(
                  context,
                  message: 'Please select a points contract',
                );
                return;
              }

              try {
                final expiry = int.tryParse(expiryController.text);
                if (expiry == null) {
                  throw Exception('Invalid expiry value');
                }

                final price = int.tryParse(priceController.text);
                if (price == null) {
                  throw Exception('Invalid price value');
                }

                final expiryDate = DateTime.now().add(Duration(days: expiry));

                await ref.read(merchantNotifierProvider.notifier).setTokenData(
                      address: address,
                      tokenId: tokenId,
                      description: descriptionController.text,
                      expiry: expiryDate.millisecondsSinceEpoch,
                      pointsContract: selectedPointsContract!,
                      price: price.toString(),
                    );

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Token added successfully')),
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
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
