import 'package:stok_takip/models/stok_model.dart';

abstract class ApiRepository {

  Future<List<String>> searchStokKodu(String query);
  Future<StokModel?> getStokByKodu(String stokKodu);
  Future<String> saveStok(StokModel stok);
  Future<void> deleteStok(String stokKodu);

}