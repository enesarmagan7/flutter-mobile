import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:proje4/services/api_repository.dart';
import 'package:proje4/models/stok_filter_model';

import '../models/stok_model.dart';

class StokService implements ApiRepository {
  static const String baseUrl = 'http://localhost:8080/api/stoklar';
  List<StokModel> allStoklar = [];
    List<StokModel> filteredStoklar = [];
     List<String> stokNames = [];


  

Future<List<String>> searchStokKodu(String query) async {
    try {
      // HTTP GET isteği gönder
      final response = await http.get(
        Uri.parse('$baseUrl/search?query=$query'),
      );

      // İstek başarılı ise
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Stok kodlarını filtrele ve döndür
        stokNames=data
            .where((stok) => stok['stokKodu'].toLowerCase().startsWith(query.toLowerCase()))
            .map((stok) => stok['stokKodu'] as String)
            .take(10)
            .toList();
            
            return stokNames;
      } else {
        throw Exception('Stok kodları aranırken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      // Hata durumunda boş liste döndür
      return [];
    }
}


Future<List<StokModel>> getStokByFilter(StokFilterModel stokFilterModel) async {
  final url = Uri.parse('http://localhost:8080/api/stoklar/filter');

  // toJson metodunu çağırarak JSON verisini oluştur
  final Map<String, dynamic> jsonBody = stokFilterModel.toJson();

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // JSON formatında olduğu söylüyorum.
      },
      body: json.encode(jsonBody), // JSON formatında body göndder
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      List<StokModel> filteredStoklar = jsonResponse
          .map((stok) => StokModel.fromJson(stok))
          .toList();
      return filteredStoklar;
    } else {
      throw Exception('Backend hatası: ${response.statusCode}');
    }
  } catch (e) {
    print('İstek sırasında hata oluştu: $e');
    throw Exception('İstek başarısız: $e');
  }
}

}
