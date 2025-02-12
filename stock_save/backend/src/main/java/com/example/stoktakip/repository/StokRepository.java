package com.example.stoktakip.repository;

import com.example.stoktakip.dto.StokDTO;
import com.example.stoktakip.entity.Stok;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository


   public interface StokRepository extends JpaRepository<Stok, Integer>, JpaSpecificationExecutor<Stok> {

    boolean existsByStokKodu(String stokKodu);
    Optional<Stok> findByStokKodu(String stokKodu);
    void deleteStokByStokKodu(String stokKodu);




    @Query("SELECT s.stokAdi FROM Stok s WHERE LOWER(s.stokKodu) LIKE LOWER(CONCAT('%', :stokKodu, '%'))")
    List<String> findByStokAdiByStokKoduLike(@Param("stokKodu") String stokKodu);
    @Query("SELECT s FROM Stok s WHERE LOWER(s.stokKodu) LIKE LOWER(CONCAT('%', :stokKodu, '%'))")
    List<Stok> findByStokKoduLike(@Param("stokKodu") String stokKodu);

    @Query("SELECT s FROM Stok s WHERE " +
            "(:stokKodu IS NULL OR :stokKodu = '' OR s.stokKodu = :stokKodu) AND " +
            "(:stokAdi IS NULL OR :stokAdi = '' OR LOWER(s.stokAdi) LIKE LOWER(CONCAT('%', :stokAdi, '%'))) AND " +
            "(:stokTipi IS NULL OR s.stokTipi = :stokTipi) AND " +
            "(:barkodu IS NULL OR :barkodu = '' OR LOWER(s.barkodu) LIKE LOWER(CONCAT('%', :barkodu, '%'))) AND " +
            "(:kdvTipi IS NULL OR s.kdvTipi = :kdvTipi)")
    List<Stok> findByFilters(
            @Param("stokKodu") String stokKodu,
            @Param("stokAdi") String stokAdi,
            @Param("stokTipi") Integer stokTipi,
            @Param("barkodu") String barkodu,
            @Param("kdvTipi") Double kdvTipi
    );
    }
