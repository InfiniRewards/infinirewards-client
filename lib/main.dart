import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinirewards/models/api_key.dart';
import 'package:infinirewards/models/app_state.dart';
import 'package:infinirewards/models/collectible_contract.dart';
import 'package:infinirewards/models/merchant.dart';
import 'package:infinirewards/models/points_contract.dart';
import 'package:infinirewards/models/saved_contract.dart';
import 'package:infinirewards/models/token.dart';
import 'package:infinirewards/models/user.dart';
import 'package:infinirewards/router.dart';

void main() async {
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(AppStateDataImplAdapter());
  Hive.registerAdapter(TokenAdapter());
  Hive.registerAdapter(UserImplAdapter());
  Hive.registerAdapter(MerchantImplAdapter());
  Hive.registerAdapter(PointsContractImplAdapter());
  Hive.registerAdapter(CollectibleContractImplAdapter());
  Hive.registerAdapter(APIKeyImplAdapter());
  Hive.registerAdapter(SavedContractImplAdapter());

  // Open Hive Boxes
  try {
    await Hive.openBox<AppStateData>("appState");
    await Hive.openBox<SavedContract>("savedContracts");
  } catch (e) {
    await Hive.deleteBoxFromDisk("appState");
    await Hive.deleteBoxFromDisk("savedContracts");
    await Hive.openBox<AppStateData>("appState");
    await Hive.openBox<SavedContract>("savedContracts");
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Custom color scheme based on InfiniRewards website
    const surfaceColor = Color(0xFF181A2F); // Dark blue for surfaces
    const primaryColor = Color(0xFF4B5C8C); // Much brighter blue as primary
    const primaryContainerColor =
        Color(0xFF6373A6); // Even brighter blue for containers
    const accentColor = Color(0xFFFF7043); // More orange accent color

    return MaterialApp.router(
      title: 'InfiniRewards',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: primaryColor,
          primaryContainer: primaryContainerColor,
          secondary: accentColor,
          secondaryContainer: accentColor.withOpacity(0.1),
          surface: surfaceColor,
          background: surfaceColor,
          error: Colors.red.shade400,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          surfaceTint: primaryContainerColor,
        ),
        scaffoldBackgroundColor: surfaceColor,
        // Custom theme data
        appBarTheme: AppBarTheme(
          backgroundColor: surfaceColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: surfaceColor,
          indicatorColor: primaryColor.withOpacity(0.2),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: primaryColor.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: accentColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        cardTheme: CardTheme(
          color: primaryColor.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.white.withOpacity(0.1),
        ),
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: primaryColor.withOpacity(0.1),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
