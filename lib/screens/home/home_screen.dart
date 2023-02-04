import 'package:archa/providers/app_state_provider.dart';
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
  List<Widget> icons = [
    Icon(Icons.sunny),
    Icon(Icons.dark_mode),
  ];

  List<bool> _selectedMode = [true, false];
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
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.search),
              ),
              IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.sort))
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
}
