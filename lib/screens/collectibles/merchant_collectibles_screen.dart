import 'package:flutter/material.dart';
import 'package:infinirewards/screens/memberships/merchant_memberships_screen.dart';
import 'package:infinirewards/screens/vouchers/merchant_vouchers_screen.dart';

class MerchantCollectiblesScreen extends StatelessWidget {
  const MerchantCollectiblesScreen({super.key});

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
            MerchantVouchersScreen(),
            MerchantMembershipsScreen(),
          ],
        ),
      ),
    );
  }
}
