import 'package:flutter/material.dart';
import 'package:archa/app.dart';
import 'package:archa/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runFrontendApp();
}

void runFrontendApp() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppStateProvider(),
      ),
    ],
    child: FrontendApp(),
  ));
}
