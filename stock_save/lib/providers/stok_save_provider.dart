import 'package:flutter/material.dart';
import 'package:stok_takip/helper/messagehelper.dart';


import 'package:stok_takip/models/stok_model.dart';
import 'package:stok_takip/services/service_locator.dart';
import 'package:stok_takip/services/stok_service.dart';

class StokProvider with ChangeNotifier {
  final StokService stokService= locator<StokService>();

  StokProvider();

  List<StokModel> _stokListesi = [];
  List<StokModel> get stokListesi => _stokListesi;



  final TextEditingController stokKoduController = TextEditingController();
  final TextEditingController stokAdiController = TextEditingController();
  final TextEditingController barkodController = TextEditingController();
  final TextEditingController aciklamaController = TextEditingController();
   String _stokAdi= '';
   String _barkod= ''; //
    String _aciklama= '';  //

  
  int _selectedStokTipi = 1; // Stok Tipi (default: Kumaş)
  String _selectedBirim = "ADET"; // Birim (default: ADET)
  double _selectedKdvTipi = 18.0;

  String get stokAdi => _stokAdi;
  String get barkod => _barkod;
  String get aciklama => _aciklama;
  int get selectedStokTipi => _selectedStokTipi;

 
  set stokKodu(String value) => stokKoduController.text = value;



  set stokAdi(String value) => {
  _stokAdi=value,
  
      
 } ;

   set barkod(String value) => {
  _barkod=value,
  
      
 } ;
   set aciklama(String value) => {
  _aciklama=value,
    
  
      
 } ;
  
  
  



  set selectedStokTipi(int value) { _selectedStokTipi = value;
  notifyListeners();
}



  String get selectedBirim => _selectedBirim;
  set selectedBirim(String value) { _selectedBirim = value;
    notifyListeners();
  }


  double get selectedKdvTipi => _selectedKdvTipi;
  set selectedKdvTipi(double value) { _selectedKdvTipi = value;
    notifyListeners();
  }


  void clearForm() {
    stokAdiController.text = '';
    stokKoduController.text = '';
    barkodController.text = '';
    aciklamaController.text = '';
    selectedKdvTipi = 18.0;
    selectedStokTipi = 1;
   
    notifyListeners();
  }




  Future<StokModel?> getStokByKodu(String stokKodu) async {

     final stok = await stokService.getStokByKodu(stokKodu);
     return stok;
  }
  
  Future<void> saveStok(BuildContext context) async {
    final stok = StokModel(
      id: null,
      stokKodu: stokKoduController.text,
      stokAdi: stokAdiController.text,
      stokTipi: selectedStokTipi,
      birimi: selectedBirim,
      barkodu:barkodController.text,
      kdvTipi: selectedKdvTipi,
      aciklama: aciklamaController.text,
    );
     final result = await stokService.saveStok(stok); 
     print(stok);
   
    if(result =='kaydedildi'){
     MessageHelper.showSuccessDialog(context, 'Stok kaydedildi.');
     
    }
    else if(result=='güncellendi') {
    MessageHelper.showSuccessDialog(context, 'Stok güncellendi.');
       
    }else{
      MessageHelper.showSnackBar(context, result);
    }
     clearForm();
    notifyListeners();
    
  }

  Future<void> deleteStok( BuildContext context) async {
     String result = await stokService.deleteStok(stokKoduController.text); 
     if(result=='silindi'){
       MessageHelper.showSuccessDialog(context, 'Stok slindi.');
     }
     else{
      MessageHelper.showSnackBar(context, result);
     }
    clearForm();
     notifyListeners();
  
  }
  
  void setStokKodu(String value) {
    stokKoduController.text = value;
     notifyListeners();
  
  }

  void setStokAdi(String value) {
    stokAdiController.text= value;
     notifyListeners();
 
  }

  void setBarkod(String value) {
    barkodController.text  = value;
     notifyListeners();

  }
    void setBirimi(String value) {
    selectedBirim = value;
     notifyListeners();
 
  }


  void setSelectedStokTipi(int value) {
    selectedStokTipi = value;
     notifyListeners();
  
  }

  void setStokKoduText(String text){
  stokKoduController.text=text;
   notifyListeners();
  }

  void setSelectedKdvTipi(double value) {
    selectedKdvTipi = value;
    notifyListeners();
  }
  void setAciklama(String value) {

    aciklama = value;
         notifyListeners();
  }
   

 Future<void> setSelectedStok(String stokKod) async {
  final stok = await stokService.getStokByKodu(stokKod);
  if (stok != null) {
    
    _setFormValuesFromStok(stok);
    
    
   
    notifyListeners();
  }
}


  void _setFormValuesFromStok(StokModel stok) {
    stokKoduController.text = stok.stokKodu;
    stokAdiController.text = stok.stokAdi;
    barkodController.text = stok.barkodu;
    aciklamaController.text = stok.aciklama;
    
    _selectedStokTipi = stok.stokTipi;
    _selectedBirim = stok.birimi;
    _selectedKdvTipi = stok.kdvTipi;
  }


}