import 'package:archa/api/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeterList extends StatefulWidget {
  MeterList({
    Key? key,
    required this.records,
  }) : super(key: key);

  List<ParkingMeter> records;
  @override
  State<MeterList> createState() => _MeterListState();
}

class _MeterListState extends State<MeterList> {
  @override
  Widget build(BuildContext context) {
    // var meters = Provider.of<MeterProvider>(context).items;
    var records = widget.records;
    return Expanded(
      child: ListView.builder(
        itemCount: records.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: (() {
              Navigator.of(context)
                  .pushNamed("/meter", arguments: records[index].recordId);
            }),
            child: Card(
              child: ListTile(
                title: Text(
                    "${records[index].streetName} | ${records[index].meterId}"),
                subtitle: Text(
                    "${records[index].barcode} | ${records[index].meterType}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (records[index].creditCard == "YES") ...[
                      const Icon(
                        FontAwesomeIcons.creditCard,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                    if (records[index].tapAndGo == "YES") ...[
                      const Icon(
                        FontAwesomeIcons.mobile,
                      )
                    ]
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
