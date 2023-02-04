import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:archa/api/api.dart';
import 'package:http/http.dart' as http;

class MeterProvider with ChangeNotifier {
  Map<String, dynamic>? params = {};
  List<FacetGroup> _facetGroups = [];

  List<ParkingMeter> _items = [];

  List<ParkingMeter> get items {
    return _items;
  }

  List<FacetGroup> get facetGroups {
    return _facetGroups;
  }

  ParkingMeter findById(String id) {
    return _items.firstWhere((element) => element.recordId == id);
  }

  FacetGroup getByFacetGroup(String groupName) {
    // TODO dynamically select a facet group
    return _facetGroups[2];
  }

  Future<void> fetchMeters(String queryParams) async {
    final url = Uri.parse(
        "https://data.melbourne.vic.gov.au/api/records/1.0/search/?dataset=on-street-car-parking-meters-with-location&q=&rows=994&facet=creditcard&facet=tapandgo&facet=streetname&facet=metertype${queryParams}");

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<ParkingMeter> loadedMeters = [];
      final List<FacetGroup> loadedFacetGroups = [];

      extractedData["records"].forEach((element) {
        loadedMeters.add(ParkingMeter.fromJson(element)!);
      });

      extractedData["facet_groups"].forEach((element) {
        loadedFacetGroups.add(FacetGroup.fromJson(element)!);
      });

      _items = loadedMeters;
      _facetGroups = loadedFacetGroups;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
