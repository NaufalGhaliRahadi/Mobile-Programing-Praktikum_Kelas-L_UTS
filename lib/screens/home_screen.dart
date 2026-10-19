import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';
import '../widgets/destination_tile.dart';
import '../widgets/popular_card.dart';
import 'list_screen.dart';

/// Halaman 1 - Beranda: sapaan, pencarian, kategori, populer, dan terbaru.
class HomeScreen extends StatelessWidget {
  final List<Destination> destinations;

  const HomeScreen({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    final popular = [...destinations]
      ..sort((a, b) => b.rating.compareTo(a.rating));
    final newest = [...destinations]
      ..sort((a, b) => b.addedDate.compareTo(a.addedDate));

    // Lebar kartu populer menyesuaikan lebar layar (responsive).
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = math.min(320.0, math.max(220.0, screenWidth * 0.7));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(onSearch: (q) => _openList(context, query: q)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (final c in kCategories)
                  _CategoryButton(
                    label: c,
                    onTap: () => _openList(context, category: c),
                  ),
              ],
            ),
            const _SectionTitle('Wisata Populer'),
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: math.min(5, popular.length),
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, i) =>
                    PopularCard(destination: popular[i], width: cardWidth),
              ),
            ),
            const _SectionTitle('Wisata Terbaru'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  for (final d in newest.take(4)) ...[
                    DestinationTile(destination: d),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _openList(BuildContext context, {String? category, String query = ''}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ListScreen(
          destinations: destinations,
          initialCategory: category,
          initialQuery: query,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const _Header({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Selamat Datang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(40),
                  child: const Icon(Icons.explore, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Mau jelajah ke mana di Malang Raya?',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 18),
            TextField(
              onSubmitted: onSearch,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Cari nama wisata...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CategoryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = categoryColor(label);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(categoryIcon(label), color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
