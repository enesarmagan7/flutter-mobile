package com.example.stoktakip.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class StokDTO {
    private Integer id;
    private String stokKodu;
    private String stokAdi;
    private Integer stokTipi;
    private String birimi;
    private String barkodu;
    private Double kdvTipi;
    private String aciklama;
    private LocalDateTime olusturmaZamani;
}
