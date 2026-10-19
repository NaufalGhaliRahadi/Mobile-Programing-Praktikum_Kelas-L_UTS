import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../widgets/destination_tile.dart';

/// Halaman 2 - Daftar wisata dengan filter kategori dan pencarian.
/// Dipakai sebagai tab "Jelajah" maupun halaman hasil dari Beranda.
class ListScreen extends StatefulWidget {
  final List<Destination> destinations;
  final String? initialCategory;
  final String initialQuery;

  const ListScreen({
    super.key,
    required this.destinations,
    this.initialCategory,
    this.initialQuery = '',
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  static const _filters = ['Semua', 'Alam', 'Budaya', 'Kuliner', 'Rekreasi'];

  late String _category;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory ?? 'Semua';
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Destination> get _filtered {
    final q = _controller.text.trim().toLowerCase();
    return widget.destinations.where((d) {
      final okCategory = _category == 'Semua' || d.category == _category;
      final okQuery = q.isEmpty ||
          d.name.toLowerCase().contains(q) ||
          d.location.toLowerCase().contains(q);
      return okCategory && okQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return Scaffold(
      appBar: AppBar(
        title: Text(_category == 'Semua' ? 'Daftar Wisata' : 'Wisata $_category'),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
            child: TextField(
              controller: _controller,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cari nama atau lokasi...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() {});
                        },
                      ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final f = _filters[i];
                return ChoiceChip(
                  label: Text(f),
                  selected: _category == f,
                  selectedColor: AppColors.accent,
                  labelStyle: TextStyle(
                    color: _category == f ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) => setState(() => _category = f),
                );
              },
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text('Wisata tidak ditemukan',
                        style: TextStyle(color: AppColors.textMuted)),
                  )
                // Grid dengan lebar maksimum per kolom: 1 kolom di HP,
                // otomatis menjadi beberapa kolom di tablet/layar lebar.
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 480,
                      mainAxisExtent: 106,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, i) => DestinationTile(destination: items[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
