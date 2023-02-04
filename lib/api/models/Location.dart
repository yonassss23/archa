import 'package:archa/api/api.dart';

class Location {
  final num? latitude;
  final num? longitude;

  const Location({this.latitude, this.longitude});

  static Location? fromJson(List json) {
    return json == null
        ? null
        : Location(
            latitude: json[0],
            longitude: json[1],
          );
  }

  static Location? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : Location(
            latitude: map["latitude"],
            longitude: map["longitude"],
          );
  }

  List toJson() => [latitude, longitude];

  List toGeomtryJson() => [longitude, latitude];

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };

  static List<Location> listFromJson(
    List<dynamic>? json, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<Location> list = <Location>[];
    if (json == null || json.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <Location>[];
      }
      return list;
    } else {
      return json
          .map((dynamic value) => Location.fromJson(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<Location> listFromMap(
    List<dynamic>? map, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<Location> list = <Location>[];
    if (map == null || map.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <Location>[];
      }
      return list;
    } else {
      return map
          .map((dynamic value) => Location.fromMap(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<Map<String, dynamic>>? listToMap(List<Location>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toMap()];
    }
  }

  static List<List>? listToJson(List<Location>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toJson()];
    }
  }

  Location? LocationFromJson(String str) => Location.fromJson(json.decode(str));

  String LocationToJson(Location data) => json.encode(data.toJson());
}
