import 'package:flutter_test/flutter_test.dart';
import 'package:jelajah_malang/main.dart';

void main() {
  testWidgets('Beranda tampil setelah data dimuat', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Selamat Datang'), findsOneWidget);
    expect(find.text('Wisata Populer'), findsOneWidget);
  });
}
