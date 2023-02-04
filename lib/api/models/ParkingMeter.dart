import 'package:archa/api/api.dart';

class ParkingMeter {
  final String? dataSetId;
  final String? recordId;
  final Location? location;
  final String? meterId;
  final String? assetId;
  final String? meterType;
  final String? barcode;
  final num? latitude;
  final num? longitude;
  final String? creditCard;
  final String? streetName;
  final String? tapAndGo;
  final Geometry? geometry;
  final DateTime? recordTimeStamp;

  const ParkingMeter(
      {this.dataSetId,
      this.recordId,
      this.location,
      this.meterId,
      this.assetId,
      this.meterType,
      this.barcode,
      this.latitude,
      this.longitude,
      this.creditCard,
      this.streetName,
      this.tapAndGo,
      this.geometry,
      this.recordTimeStamp});

  static ParkingMeter? fromJson(Map<String, dynamic>? json) {
    return json == null
        ? null
        : ParkingMeter(
            dataSetId: json["datasetid"],
            recordId: json["recordid"],
            location: Location.fromJson(json["fields"]["location"]),
            meterId: json["fields"]["meterid"],
            assetId: json["fields"]["assetid"],
            meterType: json["fields"]["metertype"],
            barcode: json["fields"]["barcode"],
            latitude: json["fields"]["latitude"],
            longitude: json["fields"]["longitude"],
            creditCard: json["fields"]["creditcard"],
            streetName: json["fields"]["streetname"],
            tapAndGo: json["fields"]["tapandgo"],
            geometry: Geometry.fromJson(json["geometry"]),
            recordTimeStamp: DateTime.parse(json["record_timestamp"]),
          );
  }

  static ParkingMeter? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : ParkingMeter(
            dataSetId: map["dataSetId"],
            recordId: map["recordId"],
            location: Location.fromMap(map["location"]),
            meterId: map["meterId"],
            assetId: map["assetId"],
            meterType: map["meterType"],
            barcode: map["barcode"],
            latitude: map["latitude"],
            longitude: map["longitude"],
            creditCard: map["creditCard"],
            streetName: map["streetName"],
            tapAndGo: map["tapAndGo"],
            geometry: Geometry.fromMap(map["geometry"]),
            recordTimeStamp: DateTime.parse(map["recordTimeStamp"]),
          );
  }

  Map<String, dynamic> toJson() => {
        "datasetid": dataSetId,
        "recordid": recordId,
        "fields": {
          "location": location == null ? location : location!.toJson(),
          "meterid": meterId,
          "assetid": assetId,
          "metertype": meterType,
          "barcode": barcode,
          "latitude": latitude,
          "longitude": longitude,
          "creditcard": creditCard,
          "streetname": streetName,
          "tapandgo": tapAndGo,
        },
        "geometry": geometry == null ? geometry : geometry!.toJson(),
        "record_timestamp": recordTimeStamp == null
            ? recordTimeStamp
            : recordTimeStamp!.toIso8601String()
      };

  Map<String, dynamic> toMap() => {
        "dataSetId": dataSetId,
        "recordId": recordId,
        "location": location == null ? location : location!.toMap(),
        "meterId": meterId,
        "assetId": assetId,
        "meterType": meterType,
        "barcode": barcode,
        "latitude": latitude,
        "longitude": longitude,
        "creditCard": creditCard,
        "streetName": streetName,
        "tapAndGo": tapAndGo,
        "geometry": geometry == null ? geometry : geometry!.toMap(),
        "recordTimeStamp": recordTimeStamp == null
            ? recordTimeStamp
            : recordTimeStamp!.toIso8601String(),
      };

  static List<ParkingMeter> listFromJson(
    List<dynamic>? json, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<ParkingMeter> list = <ParkingMeter>[];
    if (json == null || json.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <ParkingMeter>[];
      }
      return list;
    } else {
      return json
          .map((dynamic value) => ParkingMeter.fromJson(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<ParkingMeter> listFromMap(
    List<dynamic>? map, {
    bool emptyIsNull = false,
    bool growable = false,
  }) {
    List<ParkingMeter> list = <ParkingMeter>[];
    if (map == null || map.isEmpty) {
      if (emptyIsNull) {
        // TODO
        // return null in the future
        return <ParkingMeter>[];
      }
      return list;
    } else {
      return map
          .map((dynamic value) => ParkingMeter.fromMap(value)!)
          .toList(growable: true == growable);
    }
  }

  static List<Map<String, dynamic>>? listToMap(List<ParkingMeter>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toMap()];
    }
  }

  static List<Map<String, dynamic>>? listToJson(List<ParkingMeter>? list) {
    if (list == null) {
      return null;
    } else {
      return [for (int i = 0; i < list.length; i++) list[i].toJson()];
    }
  }

  ParkingMeter? ParkingMeterFromJson(String str) =>
      ParkingMeter.fromJson(json.decode(str));

  String ParkingMeterToJson(ParkingMeter data) => json.encode(data.toJson());
}
