import 'package:flutter/material.dart';
import 'package:proje4/providers/stok_providers.dart';
import 'package:proje4/widgets/stok_kart_widgets.dart';
import 'package:provider/provider.dart';

class Liste extends StatelessWidget {
  const Liste({super.key});

  @override
  Widget build(BuildContext context) {
    final stokProvider = context.watch<StokProvider>();
    return ListView.builder(
      itemCount: stokProvider.stokListesi.length,
      itemBuilder: (context, index) => SizedBox(
        height: 130,
        width: 100,
        child: StokKart(stok: stokProvider.stokListesi[index]),
      ),
    );
  }
}