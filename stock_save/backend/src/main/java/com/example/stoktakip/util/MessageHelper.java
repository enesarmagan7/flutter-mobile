package com.example.stoktakip.util;

public class MessageHelper {
    // Stok ile ilgili mesajları tanımladım
    public static String getStokNotFoundMessage(Integer id) {
        return String.format("ID: %d olan stok bulunamadı", id);
    }

    public static String getStokNotFoundByKodMessage(String stokKodu) {
        return String.format("Stok Kodu: %s olan stok bulunamadı", stokKodu);
    }

    public static String getStokKoduAlreadyExistsMessage(String stokKodu) {
        return String.format("Bu stok kodu zaten kullanımda: %s", stokKodu);
    }

    public static String getStokDeletedMessage(Integer id) {
        return String.format("ID: %d olan stok başarıyla silindi", id);
    }

    // Validasyon mesajları
    public static String getStokKoduEmptyMessage() {
        return "Stok kodu boş olamaz";
    }

    public static String getStokAdiEmptyMessage() {
        return "Stok adı boş olamaz";
    }

    public static String getInvalidStokTipiMessage(Integer tip) {
        return String.format("Geçersiz stok tipi: %d", tip);
    }

    public static String getInvalidKdvTipiMessage(Double kdv) {
        return String.format("Geçersiz KDV oranı: %.2f", kdv);
    }

    // Genel hata mesajları
    public static String getUnexpectedErrorMessage() {
        return "Beklenmeyen bir hata oluştu";
    }

    public static String getDatabaseErrorMessage() {
        return "Veritabanı işlemi sırasında bir hata oluştu";
    }
}
