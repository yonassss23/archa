import 'package:archa/api/api.dart';

class Geometry {
  final String? type;
  final Location? coordinates;

  const Geometry({this.type, this.coordinates});

  static Geometry? fromJson(Map<String, dynamic>? json) {
    return json == null
        ? null
        : Geometry(
            type: json["type"],
            coordinates: Location.fromJson([
              json["coordinates"][0],
              json["coordinates"][1],
            ]),
          );
  }

  static Geometry? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : Geometry(
            type: map["type"],
            coordinates: Location.fromMap(
              map["coordinates"],
            ),
          );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates":
            coordinates == null ? coordinates : coordinates!.toGeomtryJson(),
      };

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates":
            coordinates == null ? coordinates : coordinates!.toMap(),
      };

  static List<Geometry> listFromJson(
    List<dynamic>? json, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<Geometry> list = <Geometry>[];
    if (json == null || json.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <Geometry>[];
      }
      return list;
    } else {
      return json
          .map((dynamic value) => Geometry.fromJson(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<Geometry> listFromMap(
    List<dynamic>? map, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<Geometry> list = <Geometry>[];
    if (map == null || map.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <Geometry>[];
      }
      return list;
    } else {
      return map
          .map((dynamic value) => Geometry.fromMap(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<Map<String, dynamic>>? listToMap(List<Geometry>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toMap()];
    }
  }

  static List<Map<String, dynamic>>? listToJson(List<Geometry>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toJson()];
    }
  }

  Geometry? GeometryFromJson(String str) => Geometry.fromJson(json.decode(str));

  String GeometryToJson(Geometry data) => json.encode(data.toJson());
}
