import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:proje4/providers/stok_providers.dart';
import 'package:provider/provider.dart';

import 'package:proje4/widgets/custom_widgets.dart';

class StokFiltre extends StatelessWidget {
  const StokFiltre({super.key});

  @override
  Widget build(BuildContext context) {
    final stokProvider = context.read<StokProvider>();
     final stokProvider2 = context.watch<StokProvider>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            stokKoduRow(stokProvider),
            const SizedBox(height: 20),
            stokAdiRow(stokProvider),
            const SizedBox(height: 20),
            stokTipiRow(stokProvider,stokProvider2),
            const SizedBox(height: 20),
            barkodRow(stokProvider),
            const SizedBox(height: 20),
            kdvTipiRow(stokProvider),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

Row stokKoduRow(StokProvider stokProvider) {
  return Row(
    children: [
      const Expanded(child: Text('Stok Kodu')),
      Expanded(
        child: TypeAheadField<String>(
         
          textFieldConfiguration: TextFieldConfiguration(
            controller: stokProvider.stokKoduController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            onChanged: (value) {
              stokProvider.setStokKodu(value); // Değer değiştiğinde Provider'a set et
            },
          ),
          suggestionsCallback: (stokKodu) async {
            if (stokKodu.isEmpty) return [];
            return await stokProvider.stokService.searchStokKodu(stokKodu);
          },
          itemBuilder: (context, String suggestion) {
            return ListTile(title: Text(suggestion));
          },
          onSuggestionSelected: (String suggestion) {
            
           
            stokProvider.setStokKoduText(suggestion);// Seçilen değeri Provider'a set et
          },
        ),
      ),
    ],
  );
}
  Row kdvTipiRow(StokProvider stokProvider) {
    return Row(
      children: [
        const Expanded(child: Text('KDV Tipi')),
        Expanded(
          child: CustomWidgets.buildDropdown<double>(
            value: stokProvider.selectedKdvTipi,
            items: CustomWidgets.items<double>({
              0.0: "Hepsi",
              1.0: "%1",
              8.0: "%8",
              18.0: "%18",
            }),
            onChanged: (value)=>{ stokProvider.setSelectedKdvTipi(value)
            
            }
          ),
        ),
      ],
    );
  }

  Row barkodRow(StokProvider stokProvider) {
    return Row(
      children: [
        const Expanded(child: Text('Barkod')),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onChanged: (value)=>{ stokProvider.setBarkod(value)}
          ),
        ),
      ],
    );
  }

  Row stokTipiRow(StokProvider stokProvider,StokProvider stokProvider2) {
    return Row(
      children: [
        const Expanded(child: Text('Stok Tipi')),
        Expanded(
          child: CustomWidgets.buildDropdown<int>(
            
            value: stokProvider.selectedStokTipi,
            items: CustomWidgets.items<int>({
              0: "Hepsi",
              1: "Kumaş",
              2: "Kot",
            }),
            onChanged: (value) =>{
              stokProvider.setSelectedStokTipi(value),
              stokProvider2.setSelectedStokTipi(value),
            }
          ),
        ),
      ],
    );
  }

  Row stokAdiRow(StokProvider stokProvider) {
    return Row(
      children: [
        const Expanded(child: Text('Stok Adı')),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onChanged: (value)=>{stokProvider.setStokAdi(value)}
          ),
        ),
      ],
    );
  }
}