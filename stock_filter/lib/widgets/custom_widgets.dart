import 'package:flutter/material.dart';

class CustomWidgets {
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
  required T? value, // T? olarak işaretleyin
  required List<DropdownMenuItem<T>> items,
  required void Function(T?) onChanged,
  String? hintText,
}) {
  return InputDecorator(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value, // value null olabilir
        isExpanded: true,
        items: items,
        onChanged: onChanged,
        hint: hintText != null ? Text(hintText) : null, // value null ise hint gösterilir
      ),
    ),
  );
}
 


  // Map'i kabul eden items metodu
 static List<DropdownMenuItem<T>> items<T>(Map<T, String> map) {
  return map.entries.map((entry) {
    return DropdownMenuItem<T>(
      value: entry.key, // key null olabilir
      child: Text(entry.value),
    );
  }).toList();
}


  

}