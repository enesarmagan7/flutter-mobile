package com.example.stoktakip.mapper;

import com.example.stoktakip.dto.StokDTO;
import com.example.stoktakip.entity.Stok;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class StokMapper {
    
    private final ObjectMapper objectMapper;
    
    public StokMapper(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }
    
    public StokDTO toDTO(Stok stok) {
        return objectMapper.convertValue(stok, StokDTO.class);
    }
    
    public List<StokDTO> toDTOList(List<Stok> stokList) {
        return stokList.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }
    
    public Stok toEntity(StokDTO stokDTO) {
        return objectMapper.convertValue(stokDTO, Stok.class);
    }
    
    public void updateEntityFromDTO(StokDTO stokDTO, Stok stok) {
        Stok newStok = toEntity(stokDTO);
        stok.setStokKodu(newStok.getStokKodu());
        stok.setStokAdi(newStok.getStokAdi());
        stok.setStokTipi(newStok.getStokTipi());
        stok.setBirimi(newStok.getBirimi());
        stok.setBarkodu(newStok.getBarkodu());
        stok.setKdvTipi(newStok.getKdvTipi());
        stok.setAciklama(newStok.getAciklama());
    }
}
