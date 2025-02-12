import 'package:flutter/material.dart';
import 'package:proje4/models/stok_filter_model';
import 'package:proje4/models/stok_model.dart';
import 'package:proje4/services/stok_services.dart';
import 'package:proje4/utils/setup_locator.dart';

class StokProvider with ChangeNotifier {
  final StokService stokService= locator<StokService>();

  StokProvider();

  List<StokModel> _stokListesi = [];
  List<StokModel> get stokListesi => _stokListesi;

  String? _stokKodu;
  String? _stokAdi;
  String? _barkod;
  int? _selectedStokTipi = 0;
  double? _selectedKdvTipi = 0.0;

  String? get stokKodu => _stokKodu;
  String? get stokAdi => _stokAdi;
  String? get barkod => _barkod;
  int? get selectedStokTipi => _selectedStokTipi;
  double? get selectedKdvTipi => _selectedKdvTipi;
  TextEditingController stokKoduController=TextEditingController();

  void setStokKodu(String? value) {
    _stokKodu = value;
    notifyListeners(); // State'i güncelle
  }

  void setStokAdi(String? value) {
    _stokAdi = value;
    notifyListeners(); // State'i güncelle
  }

  void setBarkod(String? value) {
    _barkod = value;
    notifyListeners(); // State'i güncelle
  }

  void setSelectedStokTipi(int? value) {
    _selectedStokTipi = value;
    notifyListeners(); // State'i güncelle
  }

  void setStokKoduText(String text){
   _stokKodu = text;
  stokKoduController.text=text;
  notifyListeners();
  }

  void setSelectedKdvTipi(double? value) {
    _selectedKdvTipi = value;
    notifyListeners(); // State'i güncelle
  }

  Future<void> getStokListesi() async {
    StokFilterModel filter = StokFilterModel(
      stokKodu: _stokKodu?.trim(),
      stokAdi: _stokAdi?.trim(),
      stokTipi: _selectedStokTipi == 0 ? null : _selectedStokTipi,
      barkodu: _barkod?.trim(),
      kdvTipi: _selectedKdvTipi == 0.0 ? null : _selectedKdvTipi,
    );

    try {
      List<StokModel> stokListe = await stokService.getStokByFilter(filter);
      _stokListesi = stokListe;
      notifyListeners(); // State'i güncelle
    } catch (e) {
      print("Veriler yüklenemedi: $e");
    }
  }

    void showCustomDialog(BuildContext context) {
      
 showDialog(context: context, 
 builder:(context){  
  return Center(child: CircularProgressIndicator(),);
 
 }
 
  );
  

  Future.delayed(const Duration(milliseconds: 500), () {
    Navigator.of(context).pop();
  });
  notifyListeners(); 
}

  
}