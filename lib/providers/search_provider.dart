import 'package:archa/api/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  int hits = 0;
  Map<String, dynamic>? params = {};

  List<ParkingMeter> _searchResults = [];

  List<ParkingMeter> get searchResults {
    return _searchResults;
  }

  Future<void> search(String refinedQuery) async {
    final url = Uri.parse(
        "https://data.melbourne.vic.gov.au/api/records/1.0/search/?dataset=on-street-car-parking-meters-with-location&rows=1000&facet=creditcard&facet=tapandgo&facet=streetname${refinedQuery}");

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<ParkingMeter> loadedMeters = [];

      extractedData["records"].forEach((element) {
        loadedMeters.add(ParkingMeter.fromJson(element)!);
      });

      _searchResults = loadedMeters;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
