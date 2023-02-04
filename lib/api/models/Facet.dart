import 'package:archa/api/api.dart';

class Facet {
  final String? name;
  final num? count;
  final String? state;
  final String? path;

  const Facet({this.name, this.count, this.state, this.path});

  static Facet? fromJson(Map<String, dynamic>? json) {
    return json == null
        ? null
        : Facet(
            name: json["name"],
            count: json["count"],
            state: json["state"],
            path: json["path"],
          );
  }

  static Facet? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : Facet(
            name: map["name"],
            count: map["count"],
            state: map["state"],
            path: map["path"],
          );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "state": state,
        "path": path,
      };

  Map<String, dynamic> toMap() => {
        "name": name,
        "count": count,
        "state": state,
        "path": path,
      };

  static List<Facet> listFromJson(
    List<dynamic>? json, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<Facet> list = <Facet>[];
    if (json == null || json.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <Facet>[];
      }
      return list;
    } else {
      return json
          .map((dynamic value) => Facet.fromJson(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<Facet> listFromMap(
    List<dynamic>? map, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<Facet> list = <Facet>[];
    if (map == null || map.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <Facet>[];
      }
      return list;
    } else {
      return map
          .map((dynamic value) => Facet.fromMap(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<Map<String, dynamic>>? listToMap(List<Facet>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toMap()];
    }
  }

  static List<Map<String, dynamic>>? listToJson(List<Facet>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toJson()];
    }
  }

  Facet? FacetFromJson(String str) => Facet.fromJson(json.decode(str));

  String FacetToJson(Facet data) => json.encode(data.toJson());
}
