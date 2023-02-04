import 'package:archa/api/api.dart';
import 'package:archa/providers/app_state_provider.dart';
import 'package:archa/providers/meter_provider.dart';
import 'package:archa/screens/map/custom_map_view.dart';
import 'package:archa/widgets/meter_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();

  var suggestion = [];
  List searchResult = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(FontAwesomeIcons.xmark),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.chevronLeft),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchResult.clear();
    var isDarkMode =
        Provider.of<AppStateProvider>(context, listen: false).isDarkMode;
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              labelColor: isDarkMode ? Colors.white : Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(
                  icon: Icon(Icons.list),
                  text: "List",
                ),
                Tab(
                  icon: Icon(Icons.map),
                  text: "Map",
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: MeterList(),
                  ),
                  CustomMapView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    FacetGroup group =
        Provider.of<MeterProvider>(context, listen: false).getByFacetGroup("");
    var streets = group.facets!.map((e) => e.name!.toLowerCase()).toList();

    final suggestionList = query.isEmpty
        ? suggestion
        : streets.where((element) {
            return element.contains(query.toLowerCase());
          }).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
        },
        leading: Icon(query.isEmpty ? Icons.history : Icons.search),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].toString().substring(0, query.length),
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text:
                      suggestionList[index].toString().substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
