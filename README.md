# Keliling Malang

Aplikasi mobile informasi wisata Malang Raya yang dibangun dengan Flutter.
Dibuat untuk Ujian Tengah Semester (UTS) mata kuliah Mobile Programming, Semester Ganjil 2025/2026.

## Tema dan Tujuan

Tema aplikasi adalah **panduan wisata Malang Raya** (alam, budaya, kuliner, dan rekreasi).
Tujuannya membantu pengguna menemukan destinasi, membaca informasi singkat (harga, jam buka, fasilitas),
dan menyimpan destinasi favorit. Data masih berupa data dummy lokal dan dirancang agar mudah diganti dengan API.

## Daftar Halaman dan Fungsinya

| Halaman | File | Fungsi |
|---|---|---|
| Beranda | `lib/screens/home_screen.dart` | Sapaan, pencarian, ikon kategori, wisata populer, wisata terbaru |
| Daftar / Jelajah | `lib/screens/list_screen.dart` | Daftar semua wisata, filter kategori, pencarian |
| Favorit | `lib/screens/favorite_screen.dart` | Daftar wisata yang ditandai favorit |
| Detail | `lib/screens/detail_screen.dart` | Informasi lengkap satu wisata |

Navigasi: `BottomNavigationBar` (3 tab) dan `Navigator.push` (Beranda ke Daftar dan ke Detail).

## Struktur Proyek

```
lib/
  main.dart                      # titik masuk aplikasi
  models/destination.dart        # model data + fromJson/toJson
  services/
    destination_repository.dart  # sumber data (lokal JSON, siap diganti API)
    favorite_store.dart          # penyimpanan favorit di memori
  theme/app_theme.dart           # warna dan tema
  utils/helpers.dart             # ikon kategori, format tanggal, navigasi
  screens/                       # halaman aplikasi
  widgets/                       # widget yang dipakai ulang
assets/data/destinations.json    # data dummy
test/widget_test.dart            # uji sederhana
```

## Cara Menjalankan

1. Pasang Flutter SDK dan Visual Studio Code (ekstensi Flutter + Dart). Cek dengan `flutter doctor`.
2. Buat kerangka platform di folder proyek ini (hanya sekali):
   ```
   flutter create --project-name jelajah_malang .
   ```
   Jika diminta menimpa file, pastikan `lib/`, `assets/`, `pubspec.yaml`, dan `test/` dari repositori ini yang dipakai.
3. Ambil dependensi:
   ```
   flutter pub get
   ```
4. Jalankan emulator Android atau sambungkan HP, lalu:
   ```
   flutter run
   ```

## Rencana Integrasi API

`DestinationRepository` adalah kelas abstrak. Buat `ApiDestinationRepository` yang memanggil endpoint
dan memakai `Destination.fromJson`, lalu ganti satu baris di `lib/screens/main_shell.dart`.
Tampilan tidak perlu diubah.

## Catatan

Seluruh harga dan jam buka pada data adalah data dummy untuk keperluan tugas.
Gambar memakai placeholder gradasi; isi field `image_url` pada JSON untuk menampilkan foto dari internet.
