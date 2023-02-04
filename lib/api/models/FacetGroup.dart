import 'package:archa/api/api.dart';

class FacetGroup {
  final String? name;
  final List<Facet>? facets;

  const FacetGroup({this.name, this.facets});

  static FacetGroup? fromJson(Map<String, dynamic>? json) {
    return json == null
        ? null
        : FacetGroup(
            name: json["name"],
            facets: Facet.listFromJson(json["facets"]),
          );
  }

  static FacetGroup? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : FacetGroup(
            name: map["name"],
            facets: Facet.listFromMap(map["facets"]),
          );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "facets": facets == null ? facets : Facet.listToJson(facets),
      };

  Map<String, dynamic> toMap() => {
        "name": name,
        "facets": facets == null ? facets : Facet.listToMap(facets),
      };

  static List<FacetGroup> listFromJson(
    List<dynamic>? json, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<FacetGroup> list = <FacetGroup>[];
    if (json == null || json.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <FacetGroup>[];
      }
      return list;
    } else {
      return json
          .map((dynamic value) => FacetGroup.fromJson(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<FacetGroup> listFromMap(
    List<dynamic>? map, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<FacetGroup> list = <FacetGroup>[];
    if (map == null || map.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <FacetGroup>[];
      }
      return list;
    } else {
      return map
          .map((dynamic value) => FacetGroup.fromMap(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<Map<String, dynamic>>? listToMap(List<FacetGroup>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toMap()];
    }
  }

  static List<Map<String, dynamic>>? listToJson(List<FacetGroup>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toJson()];
    }
  }

  FacetGroup? FacetGroupFromJson(String str) =>
      FacetGroup.fromJson(json.decode(str));

  String FacetGroupToJson(FacetGroup data) => json.encode(data.toJson());
}
