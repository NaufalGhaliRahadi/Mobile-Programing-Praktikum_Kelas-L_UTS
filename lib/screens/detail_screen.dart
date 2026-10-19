import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/destination.dart';
import '../services/favorite_store.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';
import '../widgets/destination_image.dart';

/// Halaman 4 - Detail informasi satu destinasi.
class DetailScreen extends StatelessWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  Future<void> _openMap(BuildContext context, String urlString) async {
    if (urlString.isEmpty) return;
    final uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal membuka lokasi di Google Maps')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = destination;
    final heroHeight = math.min(420.0, MediaQuery.of(context).size.width * 0.75);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(d.name),
            actions: [
              ValueListenableBuilder<Set<int>>(
                valueListenable: FavoriteStore.ids,
                builder: (_, ids, __) => IconButton(
                  tooltip: 'Favorit',
                  icon: Icon(
                    ids.contains(d.id) ? Icons.favorite : Icons.favorite_border,
                    color: ids.contains(d.id) ? Colors.redAccent : Colors.white,
                  ),
                  onPressed: () => FavoriteStore.toggle(d.id),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: heroHeight,
              color: const Color(0xFF0B2E1A),
              child: DestinationImage(
                imageUrl: d.imageUrl,
                category: d.category,
                width: double.infinity,
                height: heroHeight,
                iconSize: 90,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Chip(
                        avatar: Icon(categoryIcon(d.category),
                            size: 16, color: categoryColor(d.category)),
                        label: Text(d.category),
                        visualDensity: VisualDensity.compact,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star,
                              color: AppColors.accent, size: 18),
                          const SizedBox(width: 4),
                          Text(d.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _InfoRow(Icons.place, 'Lokasi', d.location),
                          const Divider(height: 20),
                          _InfoRow(Icons.confirmation_number, 'Harga',
                              d.ticketPrice),
                          const Divider(height: 20),
                          _InfoRow(Icons.access_time, 'Jam buka', d.openHours),
                          const Divider(height: 20),
                          _InfoRow(Icons.event, 'Ditambahkan',
                              formatDate(d.addedDate)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (d.mapUrl.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _openMap(context, d.mapUrl),
                        icon: const Icon(Icons.map_outlined),
                        label: const Text('Buka di Google Maps'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text('Tentang',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    d.description,
                    style: const TextStyle(height: 1.5, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 20),
                  const Text('Fasilitas',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 14,
                    children: [
                      for (final f in d.facilities)
                        _FacilityItem(
                          facility: f,
                          onTap: () => _showFacility(context, f),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Ketuk fasilitas untuk melihat deskripsi',
                    style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Menampilkan deskripsi fasilitas pada bottom sheet.
void _showFacility(BuildContext context, Facility f) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: AppColors.primary.withAlpha(25),
            child: Icon(facilityIcon(f.icon),
                size: 36, color: AppColors.primary),
          ),
          const SizedBox(height: 14),
          Text(f.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            f.description.isEmpty
                ? 'Belum ada deskripsi untuk fasilitas ini.'
                : f.description,
            textAlign: TextAlign.center,
            style: const TextStyle(height: 1.5, color: AppColors.textDark),
          ),
        ],
      ),
    ),
  );
}

class _FacilityItem extends StatelessWidget {
  final Facility facility;
  final VoidCallback onTap;

  const _FacilityItem({required this.facility, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: SizedBox(
        width: 84,
        child: Column(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withAlpha(60)),
              ),
              child: Icon(facilityIcon(facility.icon),
                  size: 30, color: AppColors.primary),
            ),
            const SizedBox(height: 6),
            Text(
              facility.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        SizedBox(
          width: 90,
          child: Text(label,
              style: const TextStyle(color: AppColors.textMuted)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}