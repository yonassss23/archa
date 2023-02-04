import 'package:flutter/material.dart';
import 'package:archa/api/api.dart';
import 'package:provider/provider.dart';
import 'package:archa/providers/app_state_provider.dart';
import 'package:archa/providers/meter_provider.dart';

class MeterScreen extends StatelessWidget {
  static const routeName = '/meter';

  const MeterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordId = ModalRoute.of(context)?.settings != null
        ? ModalRoute.of(context)?.settings.arguments as String?
        : null;
    ParkingMeter meter =
        Provider.of<MeterProvider>(context, listen: false).findById(recordId!);

    return Scaffold(
      appBar: AppBar(
        title: Text(meter.meterId!),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            FieldDetail(label: "Meter Type", text: meter.meterType!),
            FieldDetail(label: "Asset Id", text: meter.assetId!),
            FieldDetail(label: "Barcode", text: meter.barcode!),
            FieldDetail(label: "Credit Card", text: meter.creditCard!),
            FieldDetail(label: "Tap and Go", text: meter.tapAndGo!),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/custom_map", arguments: meter.recordId);
                },
                child: Text("Show on Map"))
          ],
        )),
      ),
    );
    // return Column(
    //   children: [

    //   ],
    // );
  }
}

class FieldDetail extends StatelessWidget {
  const FieldDetail({Key? key, required this.label, required this.text})
      : super(key: key);
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
