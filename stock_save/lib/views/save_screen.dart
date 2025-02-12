import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:stok_takip/providers/stok_save_provider.dart';

import 'package:stok_takip/widgets/custom_widgets.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final _formKey = GlobalKey<FormState>();

  // Map tanımları
  final Map<int, String> stokTipiMap = {
    1: "Kumaş",
    2: "Kot",
    
  };

  final Map<double, String> kdvTipiMap = {
    1.0: "%1",
    8.0: "%8",
    18.0: "%18",
  };

  final Map<String, String> birimMap = {
    "ADET": "ADET",
    "KG": "KG",
    "METRE": "METRE",
    "LITRE": "LITRE",
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StokProvider(),
      child: Consumer<StokProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomWidgets.buildTypeAheadField(provider),
                  const SizedBox(height: 16),
                  CustomWidgets.buildTextField(
                    controller: provider.stokAdiController,
                    label: 'Stok Adı',
                    onChanged: (value) => { provider.stokAdi=value,
                    
                  
                    
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomWidgets.buildDropdown<int>(
                    label: 'Stok Tipi',
                    value: provider.selectedStokTipi,
                    items: CustomWidgets.items(stokTipiMap),
                    onChanged: (value) => provider.setSelectedStokTipi(value!),
                  ),
                  const SizedBox(height: 16),
                  CustomWidgets.buildDropdown<String>(
                    label: 'Birim',
                    value: provider.selectedBirim,
                    items: CustomWidgets.items(birimMap),
                    onChanged: (selectedItem) => provider.setBirimi(selectedItem!),
                  ),
                  const SizedBox(height: 16),
                  CustomWidgets.buildTextField(
                    controller: provider.barkodController,
                    label: 'Barkod',
                    onChanged: (value) => provider.barkod = value,
                  ),
                  const SizedBox(height: 16),
                  CustomWidgets.buildDropdown<double>(
                    label: 'KDV Tipi',
                    value: provider.selectedKdvTipi,
                    items: CustomWidgets.items(kdvTipiMap),
                    onChanged: (selectedItem) =>
                        provider.setSelectedKdvTipi(selectedItem!),
                  ),
                  const SizedBox(height: 16),
                  CustomWidgets.buildTextField(
                    controller: provider.aciklamaController,
                    label: 'Açıklama',
                    maxLines: 3,
                    onChanged: (value) => provider.aciklama = value,
                  ),
                  const SizedBox(height: 24),
                  CustomWidgets.buildActionButtons(provider,context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}