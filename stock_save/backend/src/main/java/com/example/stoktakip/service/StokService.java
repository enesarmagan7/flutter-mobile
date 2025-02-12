package com.example.stoktakip.service;

import com.example.stoktakip.dto.StokDTO;
import com.example.stoktakip.dto.StokFilterRequestDTO;

import java.util.List;

public interface StokService {
    List<StokDTO> getAllStoklar();
    StokDTO getStokById(Integer id);
    StokDTO getStokByKodu(String stokKodu);
    StokDTO createStok(StokDTO stokDTO);
    StokDTO updateStok(Integer id, StokDTO stokDTO);
    void deleteStok(String stokKodu);
    List<StokDTO> searchStoklar(String query);
    List<String> getStokAdi(String stokKodu);

    List<StokDTO> findStokByFilters(StokFilterRequestDTO filterRequest);
    StokDTO updateStokByKodu(String stokKodu, StokDTO stokDTO);
}
