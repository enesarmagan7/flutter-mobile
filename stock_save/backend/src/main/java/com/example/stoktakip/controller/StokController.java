package com.example.stoktakip.controller;

import com.example.stoktakip.dto.StokDTO;
import com.example.stoktakip.dto.StokFilterRequestDTO;
import com.example.stoktakip.service.StokService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/stoklar")
@CrossOrigin
public class StokController {
    private static final Logger log = LoggerFactory.getLogger(StokController.class);
    private final StokService stokService;

    public StokController(StokService stokService) {
        this.stokService = stokService;
    }

    @GetMapping
    public List<StokDTO> getAllStoklar() {
        return stokService.getAllStoklar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<StokDTO> getStokById(@PathVariable Integer id) {
        StokDTO stok = stokService.getStokById(id);
        return ResponseEntity.ok(stok);
    }

    @GetMapping("/kod/{stokKodu}")
    public ResponseEntity<StokDTO> getStokByKodu(@PathVariable String stokKodu) {
        StokDTO stok = stokService.getStokByKodu(stokKodu);
        return ResponseEntity.ok(stok);
    }

    @GetMapping("/search")
    public ResponseEntity<List<StokDTO>> searchStokKodu(@RequestParam String query) {
        List<StokDTO> stoklar = stokService.searchStoklar(query);
        return ResponseEntity.ok(stoklar);
    }
    @GetMapping("/stokAdi")
    public ResponseEntity<List<String>> searchStokAdlari(@RequestParam String query) {
        List<String> stoklar = stokService.getStokAdi(query);
        return ResponseEntity.ok(stoklar);
    }
    @PostMapping("/filter")
    public List<StokDTO> getStokByFilters(@RequestBody StokFilterRequestDTO filterRequest) {



        return stokService.findStokByFilters(
                filterRequest
        );
    }



    @PostMapping
    public ResponseEntity<StokDTO> createStok(@RequestBody StokDTO stokDTO) {
        return ResponseEntity.ok(stokService.createStok(stokDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<StokDTO> updateStok(@PathVariable Integer id, @RequestBody StokDTO stokDTO) {
        return ResponseEntity.ok(stokService.updateStok(id, stokDTO));
    }
    @PutMapping("/stok/{stokKodu}")
    public ResponseEntity<StokDTO> updateStokByKodu(@PathVariable String stokKodu, @RequestBody StokDTO stokDTO) {
        return ResponseEntity.ok(stokService.updateStokByKodu(stokKodu, stokDTO));
    }


    @DeleteMapping("/delete/{stokKodu}")
    public ResponseEntity<Void> deleteStok(@PathVariable String stokKodu) {
        stokService.deleteStok(stokKodu);
        return ResponseEntity.ok().build();
    }
}
