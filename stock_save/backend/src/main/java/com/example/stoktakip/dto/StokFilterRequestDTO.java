package com.example.stoktakip.dto;

public class StokFilterRequestDTO {

    private String stokKodu;
    private String stokAdi;
    private Integer stokTipi;
    private String barkodu;
    private Double kdvTipi;

    // Getter ve Setter metodları

    public String getStokKodu() {
        return stokKodu;
    }

    public void setStokKodu(String stokKodu) {
        this.stokKodu = stokKodu;
    }

    public String getStokAdi() {
        return stokAdi;
    }

    public void setStokAdi(String stokAdi) {
        this.stokAdi = stokAdi;
    }

    public Integer getStokTipi() {
        return stokTipi;
    }

    public void setStokTipi(Integer stokTipi) {
        this.stokTipi = stokTipi;
    }

    public String getBarkodu() {
        return barkodu;
    }

    public void setBarkodu(String barkodu) {
        this.barkodu = barkodu;
    }

    public Double getKdvTipi() {
        return kdvTipi;
    }

    public void setKdvTipi(Double kdvTipi) {
        this.kdvTipi = kdvTipi;
    }
}

