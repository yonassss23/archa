import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:archa/api/api.dart';
import 'package:provider/provider.dart';
import 'package:archa/providers/app_state_provider.dart';
import 'package:archa/providers/meter_provider.dart';
import 'package:archa/providers/search_provider.dart';
import 'package:archa/screens/map/custom_map_view.dart';
import 'package:archa/widgets/meter_list.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();

  var suggestion = [];
  List<ParkingMeter> searchResult = [];

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
    return FutureBuilder(
        future: apiSearch(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var searchProvider =
                Provider.of<SearchProvider>(context, listen: false);
            searchResult = searchProvider.searchResults;

            return DefaultTabController(
              length: 2,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      labelColor: Colors.black, //<-- selected text color
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.list,
                            color: Colors.black,
                          ),
                          text: "List",
                        ),
                        Tab(
                          icon: Icon(
                            Icons.map,
                            color: Colors.black,
                          ),
                          text: "Map",
                        )
                      ],
                    ),
                    Container(
                      //Add this to give height
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: MeterList(records: searchResult),
                        ),
                        // Container(
                        //   child: Text("map view"),
                        // )
                        CustomMapView(),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
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

  Future apiSearch(BuildContext context) async {
    var refinedQuery = query;

    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return searchProvider.search(refinedQuery);
  }
}
