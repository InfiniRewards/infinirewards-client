import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinirewards/models/api_key.dart';
import 'package:infinirewards/providers/app_state.dart';
import 'package:infinirewards/providers/user_provider.dart';
import 'package:infinirewards/utils/error_dialog.dart';
import 'package:infinirewards/providers/merchant_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(userNotifierProvider.notifier).fetchUserDetails(),
    );
  }

  Future<void> _showLogoutDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                await ref.read(appStateProvider.notifier).logout();
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
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteAccountDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              try {
                await ref.read(userNotifierProvider.notifier).deleteUser();
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
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(
    String title,
    String initialValue,
    Future<void> Function(String) onSave,
  ) {
    final controller = TextEditingController(text: initialValue);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            hintText: 'Enter your $title',
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
                await onSave(controller.text);
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
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showApiKeysDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const APIKeysDialog(),
    );
  }

  Future<void> _showCreateMerchantDialog() {
    final nameController = TextEditingController();
    final symbolController = TextEditingController();
    final decimalsController = TextEditingController(text: '18');

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Merchant Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Business Name',
                hintText: 'Enter your business name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: symbolController,
              decoration: const InputDecoration(
                labelText: 'Points Symbol',
                hintText: 'Enter points symbol (e.g., PTS)',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: decimalsController,
              decoration: const InputDecoration(
                labelText: 'Decimals',
                hintText: 'Enter decimals for points',
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
                await ref
                    .read(merchantNotifierProvider.notifier)
                    .createMerchant(
                      name: nameController.text,
                      symbol: symbolController.text,
                      decimals: int.parse(decimalsController.text),
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Merchant account created successfully'),
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
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showMerchantUpgradeDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upgrade Merchant Contract'),
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
                    .upgradeMerchantContract(
                      newClassHash: controller.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Merchant contract upgraded successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Failed to upgrade merchant contract: $e')),
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

  void _showUserUpgradeDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upgrade User Contract'),
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
                    .read(userNotifierProvider.notifier)
                    .upgradeUserContract(
                      newClassHash: controller.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('User contract upgraded successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Failed to upgrade user contract: $e')),
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

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userNotifierProvider);
    final merchantAsync = ref.watch(merchantNotifierProvider);
    final isMerchant = ref.watch(appStateProvider).isMerchant;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (isMerchant)
            IconButton(
              icon: const Icon(Icons.upgrade),
              onPressed: () => _showMerchantUpgradeDialog(context),
            ),
          IconButton(
            icon: const Icon(Icons.upgrade),
            onPressed: () => _showUserUpgradeDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) => user == null
            ? const Center(child: Text('No user data available'))
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        user.avatar != null && user.avatar!.isNotEmpty
                            ? NetworkImage(user.avatar!)
                            : null,
                    child: user.avatar == null
                        ? Text(
                            user.name.substring(0, 1).toUpperCase(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          )
                        : null,
                  ),
                  const SizedBox(height: 24),
                  _ProfileField(
                    label: 'Name',
                    value: user.name,
                    onEdit: () => _showEditDialog(
                      'Name',
                      user.name,
                      (value) => ref
                          .read(userNotifierProvider.notifier)
                          .updateUser(name: value),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ProfileField(
                    label: 'Email',
                    value: user.email,
                    onEdit: () => _showEditDialog(
                      'Email',
                      user.email,
                      (value) => ref
                          .read(userNotifierProvider.notifier)
                          .updateUser(email: value),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ProfileField(
                    label: 'Phone',
                    value: user.phoneNumber,
                  ),
                  const SizedBox(height: 16),
                  _ProfileField(
                    label: 'Account Address',
                    value: user.accountAddress,
                    copyable: true,
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 16),
                  Consumer(
                    builder: (context, ref, child) {
                      final merchantAsync = ref.watch(merchantNotifierProvider);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Merchant Account',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          merchantAsync.when(
                            data: (merchant) => merchant == null
                                ? FilledButton.icon(
                                    onPressed: _showCreateMerchantDialog,
                                    icon: const Icon(Icons.store),
                                    label:
                                        const Text('Create Merchant Account'),
                                  )
                                : ListTile(
                                    leading: const Icon(Icons.store),
                                    title: Text(merchant.name),
                                    subtitle:
                                        const Text('Switch to merchant view'),
                                    trailing: Switch(
                                      value: ref
                                          .watch(appStateProvider)
                                          .isMerchant,
                                      onChanged: (value) {
                                        ref
                                            .read(appStateProvider.notifier)
                                            .toggleMerchantMode(value);
                                      },
                                    ),
                                  ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stack) => ListTile(
                              leading: const Icon(Icons.error),
                              title:
                                  const Text('Failed to load merchant account'),
                              subtitle: TextButton(
                                onPressed: () => ref
                                    .read(merchantNotifierProvider.notifier)
                                    .fetchMerchantDetails(),
                                child: const Text('Retry'),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Theme'),
                    trailing: DropdownButton<String>(
                      value: ref.watch(appStateProvider).theme,
                      items: const [
                        DropdownMenuItem(
                          value: 'system',
                          child: Text('System'),
                        ),
                        DropdownMenuItem(
                          value: 'light',
                          child: Text('Light'),
                        ),
                        DropdownMenuItem(
                          value: 'dark',
                          child: Text('Dark'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(appStateProvider.notifier)
                              .changeTheme(value);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('API Keys'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showApiKeysDialog(context),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => _showDeleteAccountDialog(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    ),
                    child: const Text('Delete Account'),
                  ),
                ],
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load profile',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              TextButton(
                onPressed: () =>
                    ref.read(userNotifierProvider.notifier).fetchUserDetails(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onEdit;
  final bool copyable;

  const _ProfileField({
    required this.label,
    required this.value,
    this.onEdit,
    this.copyable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (copyable)
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: value));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  }
                },
              ),
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
              ),
          ],
        ),
      ],
    );
  }
}

class APIKeysDialog extends ConsumerStatefulWidget {
  const APIKeysDialog({super.key});

  @override
  ConsumerState<APIKeysDialog> createState() => _APIKeysDialogState();
}

class _APIKeysDialogState extends ConsumerState<APIKeysDialog> {
  List<APIKey>? _apiKeys;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadApiKeys();
  }

  Future<void> _loadApiKeys() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final apiKeys =
          await ref.read(userNotifierProvider.notifier).getApiKeys();

      setState(() {
        _apiKeys = apiKeys;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('API Keys'),
      content: SizedBox(
        width: double.maxFinite,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Failed to load API keys',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        TextButton(
                          onPressed: _loadApiKeys,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    children: [
                      ..._apiKeys!.map(
                        (key) => APIKeyCard(
                          apiKey: key,
                          onDelete: () async {
                            try {
                              await ref
                                  .read(userNotifierProvider.notifier)
                                  .deleteApiKey(key.id);
                              await _loadApiKeys();
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
                      ),
                      TextButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => CreateApiKeyDialog(
                            onKeyCreated: _loadApiKeys,
                          ),
                        ),
                        child: const Text('Create New API Key'),
                      ),
                    ],
                  ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class CreateApiKeyDialog extends ConsumerStatefulWidget {
  final VoidCallback onKeyCreated;

  const CreateApiKeyDialog({
    super.key,
    required this.onKeyCreated,
  });

  @override
  ConsumerState<CreateApiKeyDialog> createState() => _CreateApiKeyDialogState();
}

class _CreateApiKeyDialogState extends ConsumerState<CreateApiKeyDialog> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create API Key'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Key Name',
          hintText: 'Enter a name for your API key',
        ),
        enabled: !_isLoading,
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading
              ? null
              : () async {
                  try {
                    setState(() => _isLoading = true);
                    await ref
                        .read(userNotifierProvider.notifier)
                        .createApiKey(_controller.text);
                    if (context.mounted) {
                      Navigator.pop(context);
                      widget.onKeyCreated();
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
                  } finally {
                    if (mounted) {
                      setState(() => _isLoading = false);
                    }
                  }
                },
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }
}

class APIKeyCard extends StatelessWidget {
  final APIKey apiKey;
  final VoidCallback onDelete;

  const APIKeyCard({
    super.key,
    required this.apiKey,
    required this.onDelete,
  });

  Future<void> _copyToClipboard(
      BuildContext context, String value, String label) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$label copied to clipboard'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        apiKey.name,
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                  tooltip: 'Delete API Key',
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        apiKey.id,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () =>
                      _copyToClipboard(context, apiKey.id, 'API Key ID'),
                  tooltip: 'Copy ID',
                ),
              ],
            ),
            if (apiKey.secret != null) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secret',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          apiKey.secret!,
                          style: textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => _copyToClipboard(
                      context,
                      apiKey.secret!,
                      'API Key Secret',
                    ),
                    tooltip: 'Copy Secret',
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
