import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../services/favorite_store.dart';
import '../theme/app_theme.dart';
import '../widgets/destination_tile.dart';

/// Halaman 3 (tab) - Daftar wisata yang ditandai favorit.
class FavoriteScreen extends StatelessWidget {
  final List<Destination> destinations;

  const FavoriteScreen({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit Saya')),
      body: ValueListenableBuilder<Set<int>>(
        valueListenable: FavoriteStore.ids,
        builder: (context, ids, _) {
          final items =
              destinations.where((d) => ids.contains(d.id)).toList();
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border,
                        size: 56, color: AppColors.textMuted),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada favorit.\nBuka detail wisata lalu tekan ikon hati.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) => DestinationTile(destination: items[i]),
          );
        },
      ),
    );
  }
}
