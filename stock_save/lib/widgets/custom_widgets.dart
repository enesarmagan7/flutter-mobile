import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stok_takip/providers/stok_save_provider.dart';

class CustomWidgets {
  // TextField oluşturma metodu
  static Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onChanged: onChanged,
    );
  }

  // Dropdown oluşturma metodu
  static Widget buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
   static List<DropdownMenuItem<T>> items<T>(Map<T, String> map) {
    
    return map.entries.map((entry) {
      return DropdownMenuItem<T>(
        value: entry.key, // Map'in key değeri
        child: Text(entry.value), // Map'in value değeri
      );
    }).toList();
  }



  static Widget buildTypeAheadField(StokProvider provider) {
    return TypeAheadField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: provider.stokKoduController,
        decoration: const InputDecoration(
          labelText: 'Stok Kodu',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
      ),
      suggestionsCallback: (stokKodu) async {
        if (stokKodu.isEmpty) return [];
        return await provider.stokService.searchStokKodu(stokKodu);
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(title: Text(suggestion));
      },
      onSuggestionSelected: (String suggestion) async {
        await provider.setSelectedStok(suggestion);
      },
    );
  }

  static Widget buildActionButtons(StokProvider provider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => provider.saveStok(context),
          icon: const Icon(Icons.save),
          label: const Text('Kaydet'),
        ),
        ElevatedButton.icon(
          onPressed: () => provider.deleteStok(context),
          icon: const Icon(Icons.delete),
          label: const Text('Sil'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}