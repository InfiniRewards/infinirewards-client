import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorDialog extends StatefulWidget {
  final String message;
  final String? stackTrace;

  const ErrorDialog({
    super.key,
    required this.message,
    this.stackTrace,
  });

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  bool _showStackTrace = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 8),
          const Text('Error'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.message),
          if (widget.stackTrace != null) ...[
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _showStackTrace = !_showStackTrace;
                });
              },
              icon: Icon(
                _showStackTrace ? Icons.expand_less : Icons.expand_more,
              ),
              label: Text(
                _showStackTrace ? 'Hide Details' : 'Show Details',
              ),
            ),
            if (_showStackTrace)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    widget.stackTrace!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
          ],
        ],
      ),
      actions: [
        if (widget.stackTrace != null)
          TextButton.icon(
            onPressed: () {
              final textToCopy =
                  'Error: ${widget.message}\n\nStack Trace:\n${widget.stackTrace}';
              Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error copied to clipboard')),
                );
              });
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copy Error'),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

/// Shows an error dialog with the given message and optional stack trace
Future<void> showErrorDialog(
  BuildContext context, {
  required String message,
  dynamic error,
  StackTrace? stackTrace,
}) {
  return showDialog(
    context: context,
    builder: (context) => ErrorDialog(
      message: message,
      stackTrace: stackTrace?.toString() ?? error?.toString(),
    ),
  );
}
