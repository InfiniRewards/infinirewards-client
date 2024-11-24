import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:infinirewards/utils/format_address.dart';

class SharePointsDialog {
  static Future<void> show(
    BuildContext context, {
    required String contractAddress,
    required String name,
    required String symbol,
    String? description,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Share Points Contract',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  symbol,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    width: 240,
                    height: 240,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: contractAddress,
                      version: QrVersions.auto,
                      size: 200,
                      backgroundColor: Colors.white,
                      errorStateBuilder: (context, error) => Center(
                        child: Text(
                          'Error generating QR code',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _CopyableField(
                  label: 'Contract Address',
                  value: contractAddress,
                  formattedValue: formatAddress(contractAddress),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: contractAddress));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contract address copied to clipboard'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Address'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CopyableField extends StatelessWidget {
  final String label;
  final String value;
  final String? formattedValue;

  const _CopyableField({
    required this.label,
    required this.value,
    this.formattedValue,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 4),
        Material(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$label copied to clipboard')),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      formattedValue ?? value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Icon(
                    Icons.copy,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
} 