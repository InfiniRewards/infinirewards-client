import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinirewards/providers/points_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';

class TransferPointsScreen extends ConsumerStatefulWidget {
  const TransferPointsScreen({super.key});

  @override
  ConsumerState<TransferPointsScreen> createState() =>
      _TransferPointsScreenState();
}

class _TransferPointsScreenState extends ConsumerState<TransferPointsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedContract;
  bool _isLoading = false;

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _transfer() async {
    if (!_formKey.currentState!.validate() || _selectedContract == null) {
      await showErrorDialog(
        context,
        message: 'Please fill in all fields',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(pointsNotifierProvider.notifier).transfer(
            pointsContract: _selectedContract!,
            to: _addressController.text,
            amount: _amountController.text,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transfer successful')),
        );
        context.pop();
      }
    } catch (e, stackTrace) {
      if (mounted) {
        await showErrorDialog(
          context,
          message: e.toString(),
          error: e,
          stackTrace: stackTrace,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pointsAsync = ref.watch(pointsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Points'),
      ),
      body: pointsAsync.when(
        data: (points) => points.isEmpty
            ? Center(
                child: Text(
                  'No points contracts available',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Points Contract',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                value: _selectedContract,
                                decoration: const InputDecoration(
                                  hintText: 'Select a contract',
                                ),
                                items: points
                                    .map((contract) => DropdownMenuItem(
                                          value: contract.address,
                                          child: Text(contract.name),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() => _selectedContract = value);
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a contract';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transfer Details',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  labelText: 'Recipient Address',
                                  hintText: 'Enter recipient address',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter recipient address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _amountController,
                                decoration: const InputDecoration(
                                  labelText: 'Amount',
                                  hintText: 'Enter amount to transfer',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter amount';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: _isLoading ? null : _transfer,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Transfer'),
                      ),
                    ],
                  ),
                ),
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
    );
  }
}
