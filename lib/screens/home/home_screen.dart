import 'package:archa/providers/app_state_provider.dart';
import 'package:archa/providers/meter_provider.dart';
import 'package:archa/screens/home/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefineType _creditCard = RefineType.YES;
  RefineType? _tapAndGo;

  List<Widget> icons = [
    Icon(Icons.sunny),
    Icon(Icons.dark_mode),
  ];

  List<bool> _selectedMode = [true, false];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<MeterProvider>(context).fetchMeters('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            elevation: 4,
            floating: true,
            snap: true,
            title: Text("Parking Meter App"),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        creditCardValue: _creditCard,
                        tapAndGoValue: _tapAndGo,
                      ));
                },
                icon: Icon(FontAwesomeIcons.search),
              ),
              IconButton(
                icon: Icon(
                  Icons.filter_list,
                ),
                onPressed: () async {
                  await showFilterDialog(context);
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Center(
                  child: Column(
                children: [
                  Text(
                    "Brightness",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    onPressed: (index) {
                      for (var i = 0; i < _selectedMode.length; i++) {
                        _selectedMode[i] = i == index;
                      }
                      if (_selectedMode[0] == true)
                        Provider.of<AppStateProvider>(context, listen: false)
                            .updateTheme(false);

                      if (_selectedMode[1] == true)
                        Provider.of<AppStateProvider>(context, listen: false)
                            .updateTheme(true);
                    },
                    children: icons,
                    isSelected: _selectedMode,
                  )
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showFilterDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext build) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Center(
                  child: Text(
                "Filter",
                // style: TextStyle(color: mainColor),
              )),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 12, right: 10),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.credit_card,
                              // color: Color(0xff808080),
                            ),
                          ),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<RefineType>(
                                isExpanded: true,
                                hint: Text("Credit Card"),
                                items: <RefineType>[
                                  RefineType.YES,
                                ].map((RefineType value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.name.toUpperCase(),
                                        style: TextStyle(
                                          // color: textColor,
                                          fontSize: 16,
                                        )),
                                  );
                                }).toList(),
                                value: _creditCard,
                                onChanged: (newValue) {
                                  onCreditCardChange(newValue!);
                                  setState((() {}));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8, right: 10),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.tap_and_play,
                              // color: Color(0xff808080),
                            ),
                          ),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<RefineType>(
                                isExpanded: true,
                                hint: Text("Select ..."),
                                items: <RefineType>[
                                  RefineType.YES,
                                  RefineType.NO,
                                  RefineType.BOTH
                                ].map((RefineType value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.name.toUpperCase(),
                                        style: TextStyle(
                                          // color: textColor,
                                          fontSize: 16,
                                        )),
                                  );
                                }).toList(),
                                value: _tapAndGo,
                                onChanged: (newValue) {
                                  onTapAndGoChange(newValue!);
                                  setState((() {}));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void onCreditCardChange(RefineType value) {
    setState(() {
      _creditCard = value;
    });
  }

  void onTapAndGoChange(RefineType value) {
    setState(() {
      _tapAndGo = value;
    });
  }
}

enum RefineField { CREDITCARD, TAPANDGO, STREETNAME }

extension RefineFieldExtension on RefineField {
  String get name {
    switch (this) {
      case RefineField.CREDITCARD:
        return 'Credit Card';
      case RefineField.TAPANDGO:
        return 'Tap And Go';
      case RefineField.STREETNAME:
        return 'Street Name';
    }
  }
}

enum RefineType { YES, NO, BOTH }

extension RefineTypeExtension on RefineType {
  String get name {
    switch (this) {
      case RefineType.YES:
        return 'YES';
      case RefineType.NO:
        return 'NO';
      case RefineType.BOTH:
        return 'BOTH';
    }
  }
}
