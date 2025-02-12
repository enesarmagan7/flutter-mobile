import 'package:flutter/material.dart';
import 'package:proje4/models/stok_model.dart';

class StokKart extends StatelessWidget {
  final StokModel stok;

  const StokKart({super.key, required this.stok});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Stok Kodu', stok.stokKodu),
                  buildInfoRow('Stok Tipi', stok.stokTipi == 1 ? "Kumaş" : stok.stokTipi == 2 ? "Kot" : ""),
                  buildInfoRow('Barkodu', stok.barkodu),
                  buildInfoRow('Açıklama', stok.aciklama),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Stok Adı', stok.stokAdi),
                  buildInfoRow('Birimi', stok.birimi),
                  buildInfoRow('KDV Tipi', '%${stok.kdvTipi}'),
                  buildInfoRow('Oluşturma Zamanı', stok.olusturmaZamani!.toIso8601String()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(color: Colors.blue))),
        Expanded(child: Text(value)),
      ],
    );
  }
}