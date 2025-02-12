

class Helper {
  
  static Map<String, String> removeNullValues(Map<String, dynamic> json) {
    json.removeWhere((key, value) => value == null);
    return json.map((key, value) => MapEntry(key, value.toString()));
  }


}