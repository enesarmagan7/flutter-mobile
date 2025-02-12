import 'package:flutter/material.dart';
import 'package:stok_takip/models/stok_model.dart';
import 'package:stok_takip/services/service_locator.dart';
import 'package:stok_takip/services/stok_service.dart';

class StokSummaryProvider with ChangeNotifier {
  final StokService stokService = locator<StokService>();
  final TextEditingController stokKoduController = TextEditingController();
  StokModel? _selectedStok;

  StokModel? get selectedStok => _selectedStok;

  void setSelectedStok(StokModel? stok) {
    _selectedStok = stok;
    notifyListeners();
  }

  List<Map<String, String>> getStokSummaryData(StokModel stok) {
    return [
      {'label': 'Stok Kodu:', 'value': stok.stokKodu},
      {'label': 'Stok Adı:', 'value': stok.stokAdi},
      {'label': 'Stok Tipi:', 'value': stok.stokTipi.toString()},
      {'label': 'Birimi:', 'value': stok.birimi},
      {'label': 'Barkod:', 'value': stok.barkodu},
      {'label': 'KDV Tipi:', 'value': '% ${stok.kdvTipi}'},
      {'label': 'Açıklama:', 'value': stok.aciklama},
      if (stok.olusturmaZamani != null)
        {'label': 'Oluşturma Zamanı:', 'value': stok.olusturmaZamani!.toString()},
    ];
  }

  Future<void> selectStok(String suggestion) async {
    stokKoduController.text = suggestion;
    final stok = await stokService.getStokByKodu(suggestion);
    if (stok != null) {
      setSelectedStok(stok);
    }
  }

  @override
  void dispose() {
    stokKoduController.dispose();
    super.dispose();
  }
}