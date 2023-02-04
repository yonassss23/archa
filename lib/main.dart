import 'package:archa/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:archa/app.dart';
import 'package:provider/provider.dart';
import 'package:archa/providers/app_state_provider.dart';
import 'package:archa/providers/meter_provider.dart';

void main() {
  runFrontendApp();
}

void runFrontendApp() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MeterProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SearchProvider(),
      ),
    ],
    child: FrontendApp(),
  ));
}
