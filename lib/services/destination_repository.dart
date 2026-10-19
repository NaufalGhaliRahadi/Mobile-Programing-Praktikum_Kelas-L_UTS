import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/destination.dart';

/// Kontrak sumber data. UI hanya bergantung pada kelas abstrak ini.
abstract class DestinationRepository {
  Future<List<Destination>> fetchDestinations();
}

/// Sumber data lokal: membaca file JSON pada folder assets.
class LocalDestinationRepository implements DestinationRepository {
  static const String _assetPath = 'assets/data/destinations.json';

  @override
  Future<List<Destination>> fetchDestinations() async {
    final raw = await rootBundle.loadString(_assetPath);
    final map = json.decode(raw) as Map<String, dynamic>;
    final list = map['destinations'] as List<dynamic>;
    return list
        .map((e) => Destination.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

// TAHAP BERIKUTNYA (integrasi API):
// Buat kelas ApiDestinationRepository yang implements DestinationRepository,
// panggil endpoint dengan paket `http`, lalu decode JSON dengan
// Destination.fromJson. Ganti LocalDestinationRepository() di main_shell.dart.
