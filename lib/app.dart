import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/initializers/init_app.dart';

class _App extends StatefulWidget {
  @override
  __AppState createState() => __AppState();
}

class __AppState extends State<_App> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

Widget withScopeProvider() {
  return ProviderScope(
    child: _App(),
  );
}

Widget Function() App = withScopeProvider;
