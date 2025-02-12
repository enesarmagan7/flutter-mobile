import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'package:stok_takip/providers/stok_summary_provider.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  Widget _buildsummary(String label, String value) {      
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
       create: (context) =>  StokSummaryProvider(),
      child: Consumer<StokSummaryProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TypeAheadField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: provider.stokKoduController,
                    decoration: const InputDecoration(
                      labelText: 'Stok Kodu',
                      border: OutlineInputBorder(),
                      hintText: 'Stok kodunu girin veya seçin',
                    ),
                  ),
                  suggestionsCallback: (stokKodu) async {
                    if (stokKodu.isEmpty) return [];
                    return provider.stokService.searchStokKodu(stokKodu);
                  },
                  itemBuilder: (context, String suggestion) {
                    return ListTile(title: Text(suggestion));
                  },
                  onSuggestionSelected: (String suggestion) async {
                    await provider.selectStok(suggestion);
                  },
                ),
                const SizedBox(height: 24),
                if (provider.selectedStok != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Stok Bilgileri',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: provider
                                .getStokSummaryData(provider.selectedStok!)
                                .map((item) => _buildsummary(
                                    item['label']!, item['value']!))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}