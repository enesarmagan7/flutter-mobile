package com.example.stoktakip.service.impl;

import com.example.stoktakip.dto.StokDTO;
import com.example.stoktakip.dto.StokFilterRequestDTO;
import com.example.stoktakip.entity.Stok;
import com.example.stoktakip.exception.StokNotFoundException;
import com.example.stoktakip.exception.StokAlreadyExistsException;
import com.example.stoktakip.exception.StokValidationException;
import com.example.stoktakip.mapper.StokMapper;
import com.example.stoktakip.repository.StokRepository;
import com.example.stoktakip.service.StokService;
import com.example.stoktakip.util.MessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class StokServiceImpl implements StokService {

    private final StokRepository stokRepository;
    private final StokMapper stokMapper;

    public StokServiceImpl(StokRepository stokRepository, StokMapper stokMapper) {
        this.stokRepository = stokRepository;
        this.stokMapper = stokMapper;
    }

    @Override
    public List<StokDTO> getAllStoklar() {
        List<Stok> stoklar = stokRepository.findAll();
        return stokMapper.toDTOList(stoklar);
    }

    @Override
    public StokDTO getStokById(Integer id) {
        Stok stok = stokRepository.findById(id)
                .orElseThrow(() -> new StokNotFoundException(MessageHelper.getStokNotFoundMessage(id)));
        return stokMapper.toDTO(stok);
    }

    @Override
    public StokDTO getStokByKodu(String stokKodu) {
        if (stokKodu == null || stokKodu.trim().isEmpty()) {
            throw new StokValidationException(MessageHelper.getStokKoduEmptyMessage());
        }
        
        Stok stok = stokRepository.findByStokKodu(stokKodu)
                .orElseThrow(() -> new StokNotFoundException(MessageHelper.getStokNotFoundByKodMessage(stokKodu)));
        return stokMapper.toDTO(stok);
    }

    @Override
    public StokDTO createStok(StokDTO stokDTO) {
        validateStok(stokDTO);

        if (stokRepository.existsByStokKodu(stokDTO.getStokKodu())) {
            throw new StokAlreadyExistsException(MessageHelper.getStokKoduAlreadyExistsMessage(stokDTO.getStokKodu()));
        }

        Stok stok = stokMapper.toEntity(stokDTO);
        Stok savedStok = stokRepository.save(stok);
        return stokMapper.toDTO(savedStok);
    }

    @Override
    public StokDTO updateStok(Integer id, StokDTO stokDTO) {
        validateStok(stokDTO);

        Stok existingStok = stokRepository.findById(id)
                .orElseThrow(() -> new StokNotFoundException(MessageHelper.getStokNotFoundMessage(id)));

        if (!existingStok.getStokKodu().equals(stokDTO.getStokKodu()) &&
            stokRepository.existsByStokKodu(stokDTO.getStokKodu())) {
            throw new StokAlreadyExistsException(MessageHelper.getStokKoduAlreadyExistsMessage(stokDTO.getStokKodu()));
        }

        stokMapper.updateEntityFromDTO(stokDTO, existingStok);
        Stok updatedStok = stokRepository.save(existingStok);
        return stokMapper.toDTO(updatedStok);
    }

    @Override
    public void deleteStok(String stokKodu) {
        if (!stokRepository.existsByStokKodu(stokKodu)) {
            throw new StokNotFoundException(MessageHelper.getStokNotFoundByKodMessage(stokKodu));
        }
        stokRepository.deleteStokByStokKodu(stokKodu);
    }

    @Override
    public List<StokDTO> searchStoklar(String query) {
        List<Stok> stokDTOList=stokRepository.findByStokKoduLike(query);
        return stokMapper.toDTOList(stokDTOList).stream().limit(10).collect(Collectors.toList());}



    @Override
    public List<String> getStokAdi(String stokKodu) {
        List<String> stoklar = stokRepository.findByStokAdı"ByStokKoduLike(stokKodu);
        return stoklar.stream().limit(10).collect(Collectors.toList());
    }
    public List<StokDTO> findStokByFilters(StokFilterRequestDTO filterRequest) {
        List<Stok> stokList = stokRepository.findByFilters(
                filterRequest.getStokKodu(),
                filterRequest.getStokAdi(),
                filterRequest.getStokTipi(),
                filterRequest.getBarkodu(),
                filterRequest.getKdvTipi()
        );
        return stokMapper.toDTOList(stokList);
    }



    @Override
    public StokDTO updateStokByKodu(String stokKodu, StokDTO stokDTO) {

        Stok existingStok = stokRepository.findByStokKodu(stokKodu)
                .orElseThrow(() -> new StokNotFoundException(MessageHelper.getStokNotFoundByKodMessage(stokKodu)));
        if (!existingStok.getStokKodu().equals(stokDTO.getStokKodu()) &&
                stokRepository.existsByStokKodu(stokDTO.getStokKodu())) {
            throw new StokAlreadyExistsException(MessageHelper.getStokKoduAlreadyExistsMessage(stokDTO.getStokKodu()));
        }

        stokMapper.updateEntityFromDTO(stokDTO, existingStok);
        Stok updatedStok = stokRepository.save(existingStok);
        return stokMapper.toDTO(updatedStok);
    }

    private void validateStok(StokDTO stokDTO) {
        if (stokDTO == null) {
            throw new StokValidationException("Stok bilgileri boş olamaz");
        }
        
        if (stokDTO.getStokKodu() == null || stokDTO.getStokKodu().trim().isEmpty()) {
            throw new StokValidationException(MessageHelper.getStokKoduEmptyMessage());
        }
        
        if (stokDTO.getStokAdi() == null || stokDTO.getStokAdi().trim().isEmpty()) {
            throw new StokValidationException(MessageHelper.getStokAdiEmptyMessage());
        }
        
        if (stokDTO.getStokTipi() != null && (stokDTO.getStokTipi() < 0 || stokDTO.getStokTipi() > 99)) {
            throw new StokValidationException(MessageHelper.getInvalidStokTipiMessage(stokDTO.getStokTipi()));
        }
        
        if (stokDTO.getKdvTipi() != null && (stokDTO.getKdvTipi() < 0 || stokDTO.getKdvTipi() > 100)) {
            throw new StokValidationException(MessageHelper.getInvalidKdvTipiMessage(stokDTO.getKdvTipi()));
        }
    }
}
