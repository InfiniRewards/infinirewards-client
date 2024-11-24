import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MerchantScreen extends ConsumerStatefulWidget {
  final Widget child;

  const MerchantScreen({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<MerchantScreen> createState() => _MerchantScreenState();
}

class _MerchantScreenState extends ConsumerState<MerchantScreen> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/merchant')) {
      if (location == '/merchant') return 0;
      if (location.startsWith('/merchant/points')) return 1;
      if (location.startsWith('/merchant/collectibles')) return 2;
      if (location.startsWith('/merchant/profile')) return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/merchant');
        break;
      case 1:
        context.go('/merchant/points');
        break;
      case 2:
        context.go('/merchant/collectibles');
        break;
      case 3:
        context.go('/merchant/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.wallet),
            label: 'Points',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard),
            label: 'Collectibles',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
