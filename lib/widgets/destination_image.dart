import 'package:flutter/material.dart';

import '../utils/helpers.dart';

/// Gambar destinasi. Bila `imageUrl` kosong atau gagal dimuat, ditampilkan
/// placeholder gradasi dengan ikon kategori sehingga tampilan tetap rapi.
class DestinationImage extends StatelessWidget {
  final String imageUrl;
  final String category;
  final double? width;
  final double? height;
  final double iconSize;
  final BoxFit fit;

  const DestinationImage({
    super.key,
    required this.imageUrl,
    required this.category,
    this.width,
    this.height,
    this.iconSize = 36,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final color = categoryColor(category);
    final placeholder = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withAlpha(150)],
        ),
      ),
      child: Icon(categoryIcon(category), color: Colors.white70, size: iconSize),
    );

    if (imageUrl.isEmpty) return placeholder;

    // Path yang diawali "assets/" dibaca dari file lokal, selain itu dari internet.
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => placeholder,
      );
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => placeholder,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : placeholder,
    );
  }
}
