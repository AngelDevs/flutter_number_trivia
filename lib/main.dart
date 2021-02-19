import 'package:flutter/material.dart';
import 'package:number_trivia/app.dart';

import 'common/providers/providers.dart';

void main() async {
  await sharedPreferencesFutureProvider;
  runApp(
    App(),
  );
}
