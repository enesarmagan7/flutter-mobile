package com.example.stoktakip.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "stoklar")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Stok {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;


    @NotEmpty
    @Column(name = "stok_kodu", length = 50, unique = true)
    private String stokKodu;


    @NotEmpty
    @Column(name = "stok_adi", length = 100)
    private String stokAdi;



    @Column(name = "stok_tipi")
    private Integer stokTipi;


    @NotEmpty(message = "Birim boş olamaz")

    @Column(name = "birimi", length = 10)
    private String birimi;




    @NotEmpty
    @Column(name = "barkodu", length = 30)
    private String barkodu;



    @Column(name = "kdv_tipi")
    private Double kdvTipi;
    
    @Column(name = "aciklama", columnDefinition = "TEXT")
    private String aciklama;
    @NotNull(message = "Kdv Tipi boş olamaz!")

   

    @Column(name = "olusturma_zamani")
    private LocalDateTime olusturmaZamani;
    
    @PrePersist
    protected void onCreate() {
        olusturmaZamani = LocalDateTime.now();
    }
}
