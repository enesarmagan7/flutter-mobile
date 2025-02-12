class StokModel {
  int? id;
  String stokKodu;
  String stokAdi;
  int stokTipi;
  String birimi;
  String barkodu;
  double kdvTipi;
  String aciklama;
  DateTime? olusturmaZamani;

  StokModel({
    this.id,
    required this.stokKodu,
    required this.stokAdi,
    required this.stokTipi,
    required this.birimi,
    required this.barkodu,
    required this.kdvTipi,
    required this.aciklama,
    this.olusturmaZamani,
  });

  StokModel.fromJson(Map<String, dynamic> json)
      : stokKodu = json['stokKodu'] as String,
        stokAdi = json['stokAdi'] as String,
        stokTipi = json['stokTipi'] as int,
        birimi = json['birimi'] as String,
        barkodu = json['barkodu'] as String,
        kdvTipi = json['kdvTipi'] as double,
        aciklama = json['aciklama'] as String,
        olusturmaZamani = json['olusturmaZamani'] != null 
          ? DateTime.parse(json['olusturmaZamani'] as String)
          : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stokKodu': stokKodu,
      'stokAdi': stokAdi,
      'stokTipi': stokTipi,
      'birimi': birimi,
      'barkodu': barkodu,
      'kdvTipi': kdvTipi,
      'aciklama': aciklama,
      'olusturmaZamani': olusturmaZamani?.toIso8601String(),
    };
  }
   @override
  String toString() {
    return 'StokModel{id: $id, stokKodu: $stokKodu, stokAdi: $stokAdi, stokTipi: $stokTipi, birimi: $birimi, barkodu: $barkodu, kdvTipi: $kdvTipi, aciklama: $aciklama, olusturmaZamani: $olusturmaZamani}';
  }
}
