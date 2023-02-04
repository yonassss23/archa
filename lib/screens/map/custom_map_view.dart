import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:archa/api/api.dart' show ParkingMeter;
import 'package:archa/providers/meter_provider.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

import '../../providers/search_provider.dart';

class CustomMapView extends StatefulWidget {
  static const routeName = "/custom_map";
  const CustomMapView({Key? key}) : super(key: key);

  @override
  State<CustomMapView> createState() => _CustomMapViewState();
}

class _CustomMapViewState extends State<CustomMapView> {
  @override
  Widget build(BuildContext context) {
    final recordId = ModalRoute.of(context)?.settings != null
        ? ModalRoute.of(context)?.settings.arguments as String?
        : null;

    List<Marker> _markers;
    ParkingMeter? meter;
    if (recordId != null) {
      meter =
          Provider.of<MeterProvider>(context, listen: false).findById(recordId);
      _markers = [
        Marker(
          point: LatLng(double.parse(meter.latitude.toString()),
              double.parse(meter.longitude.toString())),
          builder: (context) => Icon(
            Icons.pin_drop,
            size: 60,
            color: Colors.blueAccent,
          ),
        )
      ];
    } else {
      _markers = Provider.of<SearchProvider>(context, listen: false)
          .searchResults
          .map(
            (meter) => Marker(
              point: LatLng(double.parse(meter.latitude.toString()),
                  double.parse(meter.longitude.toString())),
              builder: (context) => Icon(
                Icons.pin_drop,
                size: 60,
                color: Colors.blueAccent,
              ),
            ),
          )
          .toList();
    }

    return Scaffold(
      appBar: meter != null
          ? AppBar(
              title: Text("${meter.meterId}"),
            )
          : null,
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(double.parse(_markers[0].point.latitude.toString()),
              double.parse(_markers[0].point.longitude.toString())),
          zoom: recordId != null ? 18.3 : 16.0,
        ),
        layers: [
          TileLayerOptions(
            minZoom: 1,
            maxZoom: 100,
            backgroundColor: Colors.black,
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: _markers)
        ],
      ),
    );
  }
}
