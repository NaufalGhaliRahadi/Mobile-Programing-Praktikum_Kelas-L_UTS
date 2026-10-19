import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../services/destination_repository.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'list_screen.dart';

/// Kerangka utama: memuat data lalu menampilkan 3 tab dengan
/// BottomNavigationBar (Beranda, Jelajah, Favorit).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  // Ganti dengan ApiDestinationRepository() saat API sudah tersedia.
  final DestinationRepository _repository = LocalDestinationRepository();
  late final Future<List<Destination>> _future;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _future = _repository.fetchDestinations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Destination>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('Gagal memuat data: ${snapshot.error}')),
          );
        }
        final data = snapshot.data!;
        return Scaffold(
          body: IndexedStack(
            index: _index,
            children: [
              HomeScreen(destinations: data),
              ListScreen(destinations: data),
              FavoriteScreen(destinations: data),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined),
                  activeIcon: Icon(Icons.explore),
                  label: 'Jelajah'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Favorit'),
            ],
          ),
        );
      },
    );
  }
}
