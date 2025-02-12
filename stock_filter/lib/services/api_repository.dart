import 'package:proje4/models/stok_filter_model';
import 'package:proje4/models/stok_model.dart';

abstract class ApiRepository {

 Future<List<String>> searchStokKodu(String query);
 Future<List<StokModel>> getStokByFilter(StokFilterModel stokFilterModel);
}