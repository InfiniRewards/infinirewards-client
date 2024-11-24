import 'package:flutter/material.dart';
import 'package:infinirewards/screens/memberships/memberships_screen.dart';
import 'package:infinirewards/screens/vouchers/vouchers_screen.dart';

class CollectiblesScreen extends StatelessWidget {
  const CollectiblesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Collectibles'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Vouchers'),
              Tab(text: 'Memberships'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            VouchersScreen(),
            MembershipsScreen(),
          ],
        ),
      ),
    );
  }
}
