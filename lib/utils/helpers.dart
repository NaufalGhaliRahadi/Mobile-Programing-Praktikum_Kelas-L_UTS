import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../screens/detail_screen.dart';

/// Daftar kategori yang tersedia (tanpa "Semua").
const List<String> kCategories = ['Alam', 'Budaya', 'Kuliner', 'Rekreasi'];

IconData categoryIcon(String category) {
  switch (category) {
    case 'Alam':
      return Icons.landscape;
    case 'Budaya':
      return Icons.temple_buddhist;
    case 'Kuliner':
      return Icons.restaurant;
    case 'Rekreasi':
      return Icons.attractions;
    default:
      return Icons.place;
  }
}

Color categoryColor(String category) {
  switch (category) {
    case 'Alam':
      return const Color(0xFF2E7D32);
    case 'Budaya':
      return const Color(0xFF8D6E63);
    case 'Kuliner':
      return const Color(0xFFD84315);
    case 'Rekreasi':
      return const Color(0xFF1565C0);
    default:
      return Colors.grey;
  }
}

IconData facilityIcon(String key) {
  switch (key) {
    case 'parking':
      return Icons.local_parking;
    case 'toilet':
      return Icons.wc;
    case 'guide':
      return Icons.record_voice_over;
    case 'park':
      return Icons.park;
    case 'mosque':
      return Icons.mosque;
    case 'food':
      return Icons.restaurant_menu;
    case 'photo':
      return Icons.photo_camera;
    case 'bridge':
      return Icons.architecture;
    case 'stall':
      return Icons.storefront;
    case 'snorkel':
      return Icons.pool;
    case 'post':
      return Icons.eco;
    case 'restaurant':
      return Icons.restaurant;
    case 'souvenir':
      return Icons.shopping_bag;
    case 'stroller':
      return Icons.child_friendly;
    case 'dinein':
      return Icons.dinner_dining;
    case 'wifi':
      return Icons.wifi;
    case 'ac':
      return Icons.ac_unit;
    case 'pool':
      return Icons.pool;
    case 'flower':
      return Icons.local_florist;
    case 'hotel':
      return Icons.hotel;
    default:
      return Icons.check_circle_outline;
  }
}

const _bulan = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

String formatDate(DateTime d) => '${d.day} ${_bulan[d.month - 1]} ${d.year}';

/// Navigasi ke halaman detail dengan Navigator.push.
void openDetail(BuildContext context, Destination destination) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => DetailScreen(destination: destination)),
  );
}
