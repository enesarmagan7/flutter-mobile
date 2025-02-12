import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stok_takip/repository/api_repository.dart';
import '../models/stok_model.dart';

class StokService implements ApiRepository{
  static const String baseUrl = 'http://localhost:8080/api/stoklar';
  

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
        return data
            .where((stok) => stok['stokKodu'].toLowerCase().startsWith(query.toLowerCase()))
            .map((stok) => stok['stokKodu'] as String)
            .take(10)
            .toList();
      } else {
        throw Exception('Stok kodları aranırken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      // Hata durumunda boş liste döndür
      return [];
    }
}

@override
Future<StokModel?> getStokByKodu(String stokKodu) async {
  final url = Uri.parse('$baseUrl/kod/$stokKodu'); // Backend'deki API endpoint

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return StokModel.fromJson(data);
    } else if (response.statusCode == 404) {
      return null; // Stok bulunamadığında null döndür
    } else {
      throw Exception('Stok getirilemedi: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Stok getirilemedi: $e');
  }
}


@override
Future<String> saveStok(StokModel stok) async {
  try {
    final existingStok = await getStokByKodu(stok.stokKodu);

    if (existingStok != null) {
      // Güncelleme işlemi
      final response = await http.put(
        Uri.parse('$baseUrl/stok/${existingStok.stokKodu}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(stok.toJson()),
      );

      if (response.statusCode == 200) {
        return 'güncellendi';
      } else {
        return 'Güncelleme başarısız! Status Code: ${response.statusCode}';
      }
    } else {
      // Yeni kayıt işlemi
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(stok.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'kaydedildi';
      } else {
        print(stok);
        return 'Kayıt başarısız! Hata Kodu: ${response.statusCode}';
      }
    }
  } catch (e) {
    return 'İşlem başarısız: $e'; // Hata mesajını döndür
  }
}


@override
  Future<String> deleteStok(String stokKodu) async {
    try {
      final stok = await getStokByKodu(stokKodu);
     
      if (stok?.stokKodu == null) return 'Silinecek stok bulunamadı';
          
      final response = await http.delete(
        Uri.parse('$baseUrl/delete/${stok!.stokKodu}'),
      );

      if (response.statusCode != 200) {
      return('$stokKodu  silinemedi  Hata Kodu: ${response.statusCode}' );
      } 
    } catch (e) {
      return'Silme işlemi başarısız';
    }
    return 'silindi';
  }
}
