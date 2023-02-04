import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:archa/providers/app_state_provider.dart';
import 'screens/home/home_screen.dart';

class FrontendApp extends StatefulWidget {
  const FrontendApp({Key? key}) : super(key: key);

  @override
  State<FrontendApp> createState() => _FrontendAppState();
}

class _FrontendAppState extends State<FrontendApp> {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppStateProvider>(context);
    return MaterialApp(
      title: 'Parking Meter App',
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
